#!/bin/bash

PLAYER_FILE="/tmp/current_playerctl_player"

# Get list of players except brave
players=($(playerctl -l 2>/dev/null | grep -vi brave))
num_players=${#players[@]}

# Exit if no players found
if [ "$num_players" -eq 0 ]; then
    echo "NoPl"
    exit 0
fi

# Load current player or default to first
current_index=0
if [[ -f $PLAYER_FILE ]]; then
    current_player=$(cat "$PLAYER_FILE")
    for i in "${!players[@]}"; do
        if [[ "${players[$i]}" == "$current_player" ]]; then
            current_index=$i
            break
        fi
    done
fi

# Handle scroll to change player
case $BLOCK_BUTTON in
    1|4) # Scroll up
        current_index=$(( (current_index - 1 + num_players) % num_players ))
        ;;
    3|5) # Scroll down
        current_index=$(( (current_index + 1) % num_players ))
        ;;
esac

# Update current player
current_player="${players[$current_index]}"
echo "$current_player" > "$PLAYER_FILE"

# Output current player shortened
len=${#current_player}
if [ "$len" -le 4 ]; then
    echo "$current_player"
else
    first2="${current_player:0:2}"
    last2="${current_player: -2}"
    echo "${first2}${last2}"
fi
