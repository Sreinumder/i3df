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
    if [[ ! -f /tmp/prev_playing || "$(cat /tmp/prev_playing)" != "$current_playing" ]]; then
        echo "$current_playing" > /tmp/prev_playing
        ~/i3df/scripts/current_mpv_set_wallpaper.sh
    fi
elif [ "$status" == "Paused" ]; then
    echo "▶ $current_playing"
else
    echo "No media playing"
fi

