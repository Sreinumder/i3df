#!/bin/bash

# Get battery percentage
battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)

# Get battery status (Charging, Discharging, Full, Not charging, etc.)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

# Check if the battery is discharging, charging, full, or not charging
if [ "$battery_status" == "Charging" ]; then
    status="充電中"  # Charging
    color=$GREEN
elif [ "$battery_status" == "Discharging" ]; then
    status="放電中"  # Discharging
    if [ "$battery_percentage" -le 20 ]; then
        color=$RED
    else
        color=$BLUE
    fi
elif [ "$battery_status" == "Full" ]; then
    status="満充電"  # Fully Charged
    color=$GREENER
else
    status="未充電"  # Not Charging
fi

# Output the battery status with percentage
echo "$status $battery_percentage%"
# echo "$battery_percentage%"
# echo "Red"
# echo "$status $battery_percentage%\n$battery_percentage%"\n$color"
# echo "$RED"
