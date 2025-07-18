#!/bin/bash
PLAYER_FILE="/tmp/current_playerctl_player"
player=$(cat "$PLAYER_FILE" 2>/dev/null)
SCROLL_FILE="/tmp/media_scroll_index"
PREV_TRACKID_FILE="/tmp/prev_trackid"
SCROLL_LENGTH=30

players=$(playerctl -l 2>/dev/null)
[ -z "$players" ] && echo "no-media" && exit

# Get metadata safely
title=$(playerctl -p "$player" metadata --format "{{title}}" 2>/dev/null)
status=$(playerctl -p "$player" status 2>/dev/null)
artist=$(playerctl -p "$player" metadata --format "{{artist}}" 2>/dev/null)
trackid=$(playerctl -p "$player" metadata mpris:trackid 2>/dev/null)
position=$(playerctl -p "$player" position 2>/dev/null)
duration=$(playerctl -p "$player" metadata --format "{{mpris:length}}" 2>/dev/null)

duration_sec=$((duration / 1000000))
position_sec=${position%.*}

format_time() {
    local seconds=$1
    printf "%02d:%02d" $((seconds / 60)) $((seconds % 60))
}

# Scroll logic
if [[ ${#title} -gt $SCROLL_LENGTH ]]; then
    prev_trackid=$(cat "$PREV_TRACKID_FILE" 2>/dev/null || echo "")
    if [[ "$prev_trackid" != "$trackid" ]]; then
        echo "$trackid" > "$PREV_TRACKID_FILE"
        echo 0 > "$SCROLL_FILE"
    fi

    scroll_index=$(cat "$SCROLL_FILE" 2>/dev/null || echo 0)
    scroll_index=$((scroll_index + 1))
    ((scroll_index > ${#title})) && scroll_index=0
    echo "$scroll_index" > "$SCROLL_FILE"

    scroll_title="${title:$scroll_index:$SCROLL_LENGTH}"
    while [[ ${#scroll_title} -lt $SCROLL_LENGTH ]]; do
        scroll_title="$scroll_title ${title:0:$(($SCROLL_LENGTH - ${#scroll_title}))}"
    done
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
