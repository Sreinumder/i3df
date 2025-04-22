#!/bin/bash

# Get the current status of the media (playing, paused, or stopped)
status=$(playerctl status)
# Get the current media title
current_playing=$(playerctl metadata --format "{{title}}")

# Function to trim to first 5-6 words
trimmed_title() {
    echo "$1" | awk '{for(i=1;i<=4;i++) printf $i" "; if(NF>6) printf "..."; print ""}'
}

case $BLOCK_BUTTON in
  1) # Left click - Toggle mute
    playerctl play-pause
    ;;
  2) # middle-click
    playerctl previous
    ;;
  3) # Right Click
    playerctl next
    ;;
  4) # scroll up
    playerctl position 3+
    ;;
  5) # scroll down
    playerctl position 3-
    ;;
esac

# Check if there's any media playing or paused
if [ -z "$current_playing" ]; then
    echo "no media rn"
elif [ "$status" == "Playing" ]; then
    display_title=$(trimmed_title "$current_playing")
    echo "⏸ $display_title"
    if [[ ! -f /tmp/prev_playing || "$(cat /tmp/prev_playing)" != "$current_playing" ]]; then
        echo "$current_playing" > /tmp/prev_playing
        ~/i3df/scripts/current_mpv_set_wallpaper.sh
    fi
elif [ "$status" == "Paused" ]; then
    display_title=$(trimmed_title "$current_playing")
    echo "▶ $display_title"
else
    echo "No media playing"
fi

