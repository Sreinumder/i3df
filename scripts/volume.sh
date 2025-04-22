#!/bin/bash

# Read sink and port from shared file
if [ -f /tmp/current_audio_sink_port ]; then
  read -r sink current_port < <(tr '|' ' ' < /tmp/current_audio_sink_port)
else
  # fallback if file doesn't exist
  sink=$(pactl info | grep 'Default Sink' | awk '{print $3}')
  current_port=$(pactl list sinks | awk -v sink="$sink" '
    $0 ~ "Name: "sink {found=1}
    found && $1=="Active" && $2=="Port:" {print $3; exit}
  ')
fi

# Get first two ports for toggling (optional, you can adjust)
ports=$(pactl list sinks | grep -A 15 "Name: $sink" | grep 'name:' | awk '{print $2}')
port1=$(echo "$ports" | head -n 1)
port2=$(echo "$ports" | head -n 2 | tail -n 1)

# Handle clicks
case $BLOCK_BUTTON in
    1) # Left click - Toggle mute
        pactl set-sink-mute "$sink" toggle
        ;;
    3) # Right-click - Open pavucontrol (optional)
        (pavucontrol -t 3 &)
        ;;
    4)
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        ;;
    5)
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        ;;
esac

# Get volume and mute status for current sink
volume=$(pactl list sinks | awk -v sink="$sink" '
  $0 ~ "Name: "sink {found=1}
  found && $1=="Volume:" {print $5; exit}
')
muted=$(pactl list sinks | awk -v sink="$sink" '
  $0 ~ "Name: "sink {found=1}
  found && $1=="Mute:" {print $2; exit}
')

# Output
if [ "$muted" == "yes" ]; then
    echo "<span color='#e06c75'>静$volume</span>"  # Red for mute
else
    echo "音$volume"
fi
