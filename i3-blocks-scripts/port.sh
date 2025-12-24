#!/bin/bash

# Get a list of all available sinks
sinks=$(pactl list short sinks | awk '{print $1}')

# Get the currently active default sink
current_sink=$(pactl get-default-sink)

# Get the next sink in the list (or loop back to the first sink if at the end)
next_sink=$(echo "$sinks" | awk -v current="$current_sink" '
{
  if (found) { print; exit }
  if ($1 == current) found=1
}
END { if (!found) print $1 }')

# If a next sink is found, set it as the default
if [ -n "$next_sink" ]; then
  pactl set-default-sink "$next_sink"
  echo "Switched to sink: $next_sink"
else
  echo "No other sinks available."
fi
