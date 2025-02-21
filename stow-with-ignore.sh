#!/bin/bash

# Path to the .stow-ignore file
IGNORE_FILE="$HOME/i3df/.stowignore"

# Check if the .stow-ignore file exists
if [[ ! -f "$IGNORE_FILE" ]]; then
    touch IGNORE_FILE
    echo "No .stow-ignore file found. Running stow normally."
    stow "$@"
    exit 0
fi

# Read the .stow-ignore file and join patterns with '|' (regex OR)
IGNORE_PATTERNS=$(paste -sd '|' "$IGNORE_FILE")

# Run stow with the --ignore option
cd ~/i3df || { echo "Failed to cd to ~/i3df"; exit 1; }
stow --adopt --ignore="$IGNORE_PATTERNS" .
