#!/bin/bash

# Get the current brightness percentage using brightnessctl
CURRENT_BRIGHTNESS=$(brightnessctl get)
MAX_BRIGHTNESS=$(brightnessctl max)

# Calculate brightness as a percentage
PERCENTAGE=$(( 100 * CURRENT_BRIGHTNESS / MAX_BRIGHTNESS ))

# Handle mouse scroll events using BLOCK_BUTTON (4 for scroll up, 5 for scroll down)
case $BLOCK_BUTTON in
    4)
        brightnessctl set +1% > /dev/null
        ;;
    5)
        brightnessctl set 1%- > /dev/null
        ;;
esac

# Output the current brightness percentage
echo "明$PERCENTAGE%"
