#!/bin/bash

# Get the current status of the media (playing, paused, or stopped)
status=$(playerctl status)
# Get the current media title
current_playing=$(playerctl metadata --format "{{title}}")

case $BLOCK_BUTTON in
    1) # Left click - Toggle mute
        playerctl play-pause
        ;;
    2) # middle-click - Toggle port
        playerctl previous
        ;;
    3) # Right-click - Toggle port
        playerctl next
        ;;
    4) # scroll up
        playerctl position 3+
        ;;
    5) #scroll down
        playerctl position 3-
        ;;

esac
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

