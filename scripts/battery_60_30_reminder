#!/bin/bash

# ===============================
# Battery Reminder for Linux
# Keeps battery between 30–60%
# ===============================

LOW_THRESHOLD=30    # % — remind to plug in
HIGH_THRESHOLD=60   # % — remind to unplug
CHECK_INTERVAL=60   # seconds between checks

notify_low_sent=false
notify_high_sent=false

while true; do
    # Read battery capacity and charging status
    BATTERY_PATH=$(find /sys/class/power_supply/ -name "BAT*" | head -n 1)
    CAPACITY=$(cat "$BATTERY_PATH/capacity")
    STATUS=$(cat "$BATTERY_PATH/status")

    if [ "$STATUS" == "Discharging" ] && [ "$CAPACITY" -le "$LOW_THRESHOLD" ]; then
        if [ "$notify_low_sent" = false ]; then
            notify-send "🔋 Plug In Charger" "Battery low ($CAPACITY%). Plug in to maintain longevity."
            echo "🔋 Plug In Charger" "Battery low ($CAPACITY%). Plug in to maintain longevity."
            notify_low_sent=true
            notify_high_sent=false
        fi
    elif [ "$STATUS" == "Charging" ] && [ "$CAPACITY" -ge "$HIGH_THRESHOLD" ]; then
        if [ "$notify_high_sent" = false ]; then
            notify-send "⚡ Unplug Charger" "Battery high ($CAPACITY%). Unplug to prevent overcharging."
            echo "⚡ Unplug Charger" "Battery high ($CAPACITY%). Unplug to prevent overcharging."
            notify_high_sent=true
            notify_low_sent=false
        fi
    fi

    sleep "$CHECK_INTERVAL"
done
