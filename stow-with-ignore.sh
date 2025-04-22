#!/bin/bash

IGNORE_FILE="$HOME/i3df/.stowignore"

if [[ ! -f "$IGNORE_FILE" ]]; then
    touch IGNORE_FILE
    echo "No .stow-ignore file found. Running stow normally."
    stow "$@"
    exit 0
fi

IGNORE_PATTERNS=$(paste -sd '|' "$IGNORE_FILE")

cd ~/i3df || { echo "Failed to cd to ~/i3df"; exit 1; }
# echo $IGNORE_PATTERNS
stow --adopt --ignore="$IGNORE_PATTERNS" .
