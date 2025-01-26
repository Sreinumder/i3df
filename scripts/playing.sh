#!/bin/bash

# Get the current status of the media (playing, paused, or stopped)
status=$(playerctl status)
# Get the current media title
current_playing=$(playerctl metadata --format "{{title}}")

# Check if there's any media playing or paused
if [ -z "$current_playing" ]; then
    echo "メディア再生なし"
elif [ "$status" == "Playing" ]; then
    echo "⏸ $current_playing"
elif [ "$status" == "Paused" ]; then
    echo "▶ $current_playing"
else
    echo "No media playing"
fi
