#!/bin/bash

# Get the focused window ID
WIN_ID=$(i3-msg -t get_tree | jq '.. | objects | select(.focused?) | .id')

# Get the current border style
CURRENT_BORDER=$(i3-msg -t get_tree | jq ".. | objects | select(.id==$WIN_ID) | .border")

# Toggle border style
if [[ "$CURRENT_BORDER" == "\"normal\"" ]]; then
    i3-msg "[con_id=$WIN_ID] border pixel 0"
else
    i3-msg "[con_id=$WIN_ID] border normal"
fi
