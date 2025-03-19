#!/bin/bash

# Get default sink
sink=$(pactl get-default-sink)

# List all ports for the current sink
ports=$(pactl list sinks | grep -A 15 "Name: $sink" | grep 'name:' | awk '{print $2}')

# Store the currently active port
current_port=$(pactl list sinks | grep -A 15 "Name: $sink" | grep 'Active Port' | awk '{print $3}')

# Get the first and second available ports (assuming two ports)
port1=$(echo "$ports" | head -n 1)
port2=$(echo "$ports" | head -n 2 | tail -n 1)

# Check for mouse scroll events using BLOCK_BUTTON (4 for scroll up, 5 for scroll down)
case $BLOCK_BUTTON in
    1) # Left click - Toggle mute
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        ;;
    3) # Right-click - Toggle port
        if [ "$current_port" == "$port1" ]; then
            pactl set-sink-port $sink $port2
        else
            pactl set-sink-port $sink $port1
        fi
        ;;
    4) # Scroll down - Decrease volume by 5%
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        ;;
    5) # Scroll up - Increase volume by 5%
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        ;;
esac

# Get the current volume using pactl
volume=$(pactl list sinks | grep -E '^[[:space:]]*Volume' | head -n 1 | awk '{print $5}')

# Check if volume is muted
muted=$(pactl list sinks | grep -E '^[[:space:]]*Mute' | awk '{print $2}')

# Output with color based on mute status
if [ "$muted" == "yes" ]; then
    echo "<span color='#e06c75'>静 $volume</span>"  # Red for mute
else
    echo "音 $volume"
fi
