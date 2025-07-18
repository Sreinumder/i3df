#!/bin/bash

SCROLL_FILE="/tmp/media_scroll_index"
PREV_TITLE_FILE="/tmp/prev_playing"
SCROLL_LENGTH=30

# Get media status and title
status=$(playerctl status 2>/dev/null)
title=$(playerctl metadata --format "{{title}}" 2>/dev/null)
position=$(playerctl position 2>/dev/null)
duration=$(playerctl metadata --format "{{mpris:length}}" 2>/dev/null)

# Convert microseconds to mm:ss
format_time() {
    local seconds=$1
    printf "%02d:%02d" $((seconds / 60)) $((seconds % 60))
}

# Convert microseconds to seconds
duration_sec=$((duration / 1000000))
position_sec=${position%.*}

# Scroll logic
scroll_title="$title"
if [[ ${#title} -gt $SCROLL_LENGTH ]]; then
    # Reset scroll index if song has changed
    if [[ ! -f $PREV_TITLE_FILE || "$(cat "$PREV_TITLE_FILE")" != "$title" ]]; then
        echo "$title" > "$PREV_TITLE_FILE"
        echo 0 > "$SCROLL_FILE"
    fi

    scroll_index=$(cat "$SCROLL_FILE" 2>/dev/null || echo 0)
    scroll_index=$((scroll_index + 1))

    # Loop back if out of bounds
    if (( scroll_index > ${#title} )); then
        scroll_index=0
    fi

    echo "$scroll_index" > "$SCROLL_FILE"

    scroll_title="${title:$scroll_index:$SCROLL_LENGTH}"
    # Pad if too short
    while [[ ${#scroll_title} -lt $SCROLL_LENGTH ]]; do
        scroll_title="$scroll_title ${title:0:$(($SCROLL_LENGTH - ${#scroll_title}))}"
    done
fi

# Handle mouse clicks
case $BLOCK_BUTTON in
    1) playerctl play-pause ;;
    2) playerctl previous ;;
    3) playerctl next ;;
    4) playerctl position 3+ ;;
    5) playerctl position 3- ;;
esac

# Output to i3blocks
if [ -z "$title" ]; then
    echo "no-media"
elif [ "$status" == "Playing" ]; then
    echo -n "⏸ $scroll_title"
    echo " [$(format_time $position_sec)/$(format_time $duration_sec)]"
    if [[ ! -f $PREV_TITLE_FILE || "$(cat $PREV_TITLE_FILE)" != "$title" ]]; then
        echo "$title" > $PREV_TITLE_FILE
        ~/i3df/scripts/current_mpv_set_wallpaper.sh
    fi
elif [ "$status" == "Paused" ]; then
    echo -n "▶ $scroll_title"
    echo "[$(format_time $position_sec)/$(format_time $duration_sec)]"
else
    echo "No media"
fi
