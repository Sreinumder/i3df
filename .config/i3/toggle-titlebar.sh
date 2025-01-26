#!/bin/bash

# File to store the title bar toggle state
STATE_FILE="$HOME/.config/i3/titlebar_state"

# Initialize the state file if it doesn't exist
if [[ ! -f "$STATE_FILE" ]]; then
    echo "enabled" > "$STATE_FILE"
fi

# Read the current state
state=$(cat "$STATE_FILE")

if [[ "$state" == "enabled" ]]; then
    # Disable title bars for all windows
    i3-msg 'for_window [class=".*"] border pixel 1'
    echo "disabled" > "$STATE_FILE"
    notify-send "i3" "Title bars disabled for all windows"
else
    # Enable title bars for all windows
    i3-msg 'for_window [class=".*"] border normal'
    echo "enabled" > "$STATE_FILE"
    notify-send "i3" "Title bars enabled for all windows"
fi
