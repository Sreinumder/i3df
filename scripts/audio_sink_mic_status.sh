#!/usr/bin/env bash

# Temporary file for storing current selection
STATE_FILE="/tmp/current_audio_sink_port"

# Build full list of sink|port pairs
pairs=()
while IFS= read -r sink; do
  mapfile -t ports < <(pactl list sinks | awk -v sink="$sink" '
    $0 ~ "Name: "sink {found=1}
    found && $0 ~ "Ports:" {in_ports=1}
    found && in_ports && $1 ~ /[a-zA-Z0-9\-_]+:/ {gsub(":", "", $1); print $1}
    found && in_ports && $0 ~ "Active Port" {exit}
  ')
  for port in "${ports[@]}"; do
    if echo "$port" | grep -vi "Ports" >/dev/null; then 
      pairs+=( "$sink|$port" )
    fi
  done
done < <(pactl list short sinks | awk '{print $2}')

# Determine current sink and port
if [ -f "$STATE_FILE" ]; then
  read -r current_sink current_port < <(tr '|' ' ' < "$STATE_FILE")
else
  current_sink=$(pactl info | grep 'Default Sink' | awk '{print $3}')
  current_port=$(pactl list sinks | awk -v sink="$current_sink" '
    $0 ~ "Name: "sink {found=1}
    found && $1=="Active" && $2=="Port:" {print $3; exit}
  ')
fi

# Find current index
current_index=-1
for i in "${!pairs[@]}"; do
  sink=$(echo "${pairs[$i]}" | cut -d'|' -f1)
  port=$(echo "${pairs[$i]}" | cut -d'|' -f2)
  if [[ "$sink" == "$current_sink" && "$port" == "$current_port" ]]; then
    current_index=$i
    break
  fi
done

# Default to first if not found
if [ "$current_index" -lt 0 ]; then
  current_index=0
fi

# Handle input
case "$BLOCK_BUTTON" in
  4|1)  # Next (scroll up or left click)
    next_index=$(( (current_index + 1) % ${#pairs[@]} ))
    ;;
  5)  # Previous (scroll down)
    next_index=$(( (current_index - 1 + ${#pairs[@]}) % ${#pairs[@]} ))
    ;;
  3)  # Right click: toggle mic mute
    mic_source=$(pactl list short sources | grep -v monitor | awk '{print $2}' | head -n 1)
    mic_mute=$(pactl get-source-mute "$mic_source" | awk '{print $2}')
    if [[ "$mic_mute" == "yes" ]]; then
      pactl set-source-mute "$mic_source" 0
    else
      pactl set-source-mute "$mic_source" 1
    fi
    next_index=$current_index
    ;;
  *)  # No input: keep current
    next_index=$current_index
    ;;
esac

# Extract sink and port for next_index
next_sink=$(echo "${pairs[$next_index]}" | cut -d'|' -f1)
next_port=$(echo "${pairs[$next_index]}" | cut -d'|' -f2)

# Apply changes
pactl set-default-sink "$next_sink"
for input in $(pactl list short sink-inputs | awk '{print $1}'); do
  pactl move-sink-input "$input" "$next_sink"
done
pactl set-sink-port "$next_sink" "$next_port"


# Get sink and port description
sink_desc=$(pactl list sinks | grep -A10 "Name: $next_sink" | grep "Description" | cut -d ':' -f2- | sed 's/^ //')
port_desc=$(pactl list sinks | awk -v sink="$next_sink" -v port="$next_port" '
  $0 ~ "Name: "sink {found=1}
  found && $0 ~ "Ports:" {in_ports=1}
  in_ports && $0 ~ port {getline; gsub(/^[ \t]+Description: /, ""); print; exit}
')

# Mic mute status
mic_source=$(pactl list short sources | grep -v monitor | awk '{print $2}' | head -n 1)
mic_mute=$(pactl get-source-mute "$mic_source" | awk '{print $2}')

if echo "$next_port" | grep -i "speaker" >/dev/null; then
    sink_icon="s"
elif echo "$next_port" | grep -i "headphones" >/dev/null; then 
    sink_icon="h"
else
    sink_icon="b"
fi
if [[ "$mic_mute" == "yes" ]]; then
    mic_icon="m"
else
    mic_icon="x"
fi

# Save state
echo "$next_sink|$next_port" > "$STATE_FILE"

echo "$sink_icon$mic_icon"
# echo "$next_sink|$next_port"
