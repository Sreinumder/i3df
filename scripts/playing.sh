#!/bin/bash
PLAYER_FILE="/tmp/current_playerctl_player"
player=$(cat "$PLAYER_FILE" 2>/dev/null)
SCROLL_FILE="/tmp/media_scroll_index"
PREV_TRACKID_FILE="/tmp/prev_trackid"
SCROLL_LENGTH=30

players=$(playerctl -l 2>/dev/null)
[ -z "$players" ] && echo "no-media" && exit

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
    scroll_title="$title"
fi

# Handle mouse clicks
case $BLOCK_BUTTON in
    1) playerctl -p "$player" play-pause ;;
    2) playerctl -p "$player" previous ;;
    3) playerctl -p "$player" next ;;
    4) playerctl -p "$player" position 3+ ;;
    5) playerctl -p "$player" position 3- ;;
esac

# Output
# echo "▶ $artist $scroll_title [$(format_time $position_sec)/$(format_time $duration_sec)]"
# echo $status

if [ "$status" == "Playing" ]; then
    echo "⏸ $artist $scroll_title [$(format_time $position_sec)/$(format_time $duration_sec)]"
elif [ "$status" == "Paused" ]; then
    echo "▶  $artist $scroll_title [$(format_time $position_sec)/$(format_time $duration_sec)]"
else
    echo "no-media"
fi
