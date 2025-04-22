#!/bin/bash

# Define colors for visibility on a black background
COLOR_DEFAULT="#FFFFFF"   # Default white
COLOR_CHARGING="#00FF00"  # Bright green for charging
COLOR_LOW="#FFA500"       # Orange for low battery (<= 20%)
COLOR_CRITICAL="#FF0000"  # Red for critical battery (<= 10%)

# Define paths for notification sounds
CHIME_SOUND="/usr/share/sounds/freedesktop/stereo/complete.oga"
CHARGER_CONNECTED_SOUND="/usr/share/sounds/freedesktop/stereo/device-added.oga"
CHARGER_DISCONNECTED_SOUND="/usr/share/sounds/freedesktop/stereo/device-removed.oga"

# Temporary file to track notification states
NOTIFICATION_STATE_FILE="/tmp/battery_notification_state"

# Get battery percentage
battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)

# Get battery status (Charging, Discharging, Full, Not charging, etc.)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

# Initialize variables
status=""
color="$COLOR_DEFAULT"

# Function to play a sound in the background
play_sound() {
    local sound_file="$1"
    if command -v mpv &>/dev/null; then
        mpv --no-terminal "$sound_file" &
    elif command -v paplay &>/dev/null; then
        paplay "$sound_file" &
    fi
}

# Read the last notification state from the file
if [ -f "$NOTIFICATION_STATE_FILE" ]; then
    source "$NOTIFICATION_STATE_FILE"
else
    last_battery_percentage=100
    last_battery_status="Unknown"
fi

# Check if the battery is discharging, charging, full, or not charging
if [ "$battery_status" == "Charging" ]; then
    status="C:"  # Charging
    color=$COLOR_CHARGING
    if [ "$last_battery_status" != "Charging" ]; then
        notify-send -u normal "Charger Connected" "Battery is now charging."
        play_sound "$CHARGER_CONNECTED_SOUND"
    fi
elif [ "$battery_status" == "Discharging" ]; then
    status="D:"  # Discharging
    if [ "$battery_percentage" -le 10 ] && [ "$last_battery_percentage" -gt 10 ]; then
        notify-send -u critical "Battery Critical!" "Battery is at ${battery_percentage}%! Please charge your device immediately."
        play_sound "$CHIME_SOUND"
    elif [ "$battery_percentage" -le 20 ] && [ "$last_battery_percentage" -gt 20 ]; then
        notify-send -u normal "Battery Low" "Battery is at ${battery_percentage}%. Consider charging your device."
        play_sound "$CHIME_SOUND"
    fi
    if [ "$last_battery_status" == "Charging" ]; then
        notify-send -u normal "Charger Disconnected" "Battery is now discharging."
        play_sound "$CHARGER_DISCONNECTED_SOUND"
    fi
elif [ "$battery_status" == "Full" ]; then
    status="C:"  # Fully Charged
    color=$COLOR_CHARGING
else
    status="D:"  # Not Charging
fi

case $BLOCK_BUTTON in
  1)
# wifi_toggle() {
    if iwconfig wlan0 | grep "Interface doesn't exist"; then
        echo "Enabling WiFi..."
        sudo nmcli radio wifi on
    else
        echo "Disabling WiFi..."
        sudo nmcli radio wifi off
    fi
    ;;
  # }
esac
# Save the current battery state to the file
echo "last_battery_percentage=$battery_percentage" > "$NOTIFICATION_STATE_FILE"
echo "last_battery_status=$battery_status" >> "$NOTIFICATION_STATE_FILE"

# Output the battery status with percentage and color for i3blocks
echo "<span color='$color'>$status$battery_percentage%</span>"
