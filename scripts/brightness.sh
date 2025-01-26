#!/bin/bash

# Get the current brightness level
BRIGHTNESS_PATH="/sys/class/backlight/intel_backlight/brightness"
MAX_BRIGHTNESS_PATH="/sys/class/backlight/intel_backlight/max_brightness"

# Check if the paths exist (handle different backlight drivers)
if [ -f "$BRIGHTNESS_PATH" ] && [ -f "$MAX_BRIGHTNESS_PATH" ]; then
    CURRENT_BRIGHTNESS=$(cat $BRIGHTNESS_PATH)
    MAX_BRIGHTNESS=$(cat $MAX_BRIGHTNESS_PATH)
    
    # Calculate brightness as a percentage
    PERCENTAGE=$(( 100 * CURRENT_BRIGHTNESS / MAX_BRIGHTNESS ))
    
    # Output the current brightness percentage
    echo "明 $PERCENTAGE%"
fi
