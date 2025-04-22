#!/bin/bash

direction="$1"

focused_id=$(swaymsg -t get_tree | jq -r '.. | select(.type? == "con" and .focused == true) | .id')
window_ids_array=($( swaymsg -t get_tree| jq -r 'recurse(.nodes[]?) | recurse(.floating_nodes[]?) | select(.type=="con"), select(.type=="floating_con") | select((.app_id != null) or .name != null) | {id, app_id, name} | .id'))

echo window_ids_array

if [ -z "$focused_id" ] || [ ${#window_ids_array[@]} -le 1 ]; then
  echo "No other windows to focus."
  exit 1
fi

focused_index=-1
for i in "${!window_ids_array[@]}"; do
  if [ "${window_ids_array[$i]}" -eq "$focused_id" ]; then
    focused_index=$i
    break
  fi
done

if [ "$focused_index" -ne -1 ]; then
  case "$direction" in
    "next")
      next_index=$(( (focused_index + 1) % ${#window_ids_array[@]} ))
      swaymsg "[con_id=${window_ids_array[$next_index]}] focus"
      ;;
    "previous")
      previous_index=$(( (focused_index - 1 + ${#window_ids_array[@]}) % ${#window_ids_array[@]} ))
      swaymsg "[con_id=${window_ids_array[$previous_index]}] focus"
      ;;
    *)
      echo "Usage: $0 [next|previous]"
      exit 1
      ;;
  esac
else
  echo "Could not find the focused window in the global window list."
  exit 1
fi
