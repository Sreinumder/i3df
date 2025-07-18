#!/bin/bash

# Check if WiFi is connected using nmcli
wifi_name=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d':' -f2)
if [ -n "$wifi_name" ]; then
    # If WiFi is connected, display the WiFi SSID with first 2 and last 2 characters
    wifi_name_lower=$(echo "$wifi_name" | tr '[:upper:]' '[:lower:]')
    if [[ "$wifi_name_lower" == *"5g"* ]]; then
        wifi_status="$(echo "$wifi_name" | awk '{print substr($0, 1, 2)}')5G"
    else
        wifi_status="$(echo "$wifi_name" | awk '{print substr($0, 1, 4)}')"
    fi

    echo "W$wifi_status"
else
    # If no WiFi is connected, check for Ethernet connection
    if nmcli dev status | grep -q 'ethernet' && nmcli dev status | grep -q 'connected'; then
        # Get Ethernet speed
        eth_interface=$(nmcli dev status | grep 'ethernet' | grep 'connected' | awk '{print $1}')
        speed=$(ethtool "$eth_interface" 2>/dev/null | grep 'Speed' | awk '{print $2}')
        echo "E$speed"
    else
        # If neither WiFi nor Ethernet is connected, print "Disconnected"
        echo "DC"
    fi
fi
