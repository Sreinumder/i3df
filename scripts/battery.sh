#!/bin/bash

# Define colors for visibility on a black background
COLOR_DEFAULT="#FFFFFF"   # Default white
COLOR_CHARGING="#00FF00"  # Bright green for charging
COLOR_LOW="#FFA500"       # Orange for low battery (<= 20%)
COLOR_CRITICAL="#FF0000"  # Red for critical battery (<= 10%)

# Get battery percentage
battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)

# Get battery status (Charging, Discharging, Full, Not charging, etc.)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

# Initialize variables
status=""
color="$COLOR_DEFAULT"

# Check if the battery is discharging, charging, full, or not charging
if [ "$battery_status" == "Charging" ]; then
    status="充電中"  # Charging
    color=$COLOR_CHARGING
elif [ "$battery_status" == "Discharging" ]; then
    status="放電中"  # Discharging
    if [ "$battery_percentage" -le 10 ]; then
        color=$COLOR_CRITICAL
        notify-send -u critical "Battery Critical!" "Battery is at ${battery_percentage}%! Please charge your device immediately."
    elif [ "$battery_percentage" -le 20 ]; then
        color=$COLOR_LOW
        notify-send -u normal "Battery Low" "Battery is at ${battery_percentage}%. Consider charging your device."
    fi
elif [ "$battery_status" == "Full" ]; then
    status="満充電"  # Fully Charged
    color=$COLOR_CHARGING
else
    status="未充電"  # Not Charging
fi

# Output the battery status with percentage and color for i3blocks
echo "<span color='$color'>$status $battery_percentage%</span>"
