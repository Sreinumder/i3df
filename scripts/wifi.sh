#!/bin/bash

# Check if WiFi is connected
wifi_name=$(iwgetid -r)
if [ -n "$wifi_name" ]; then
    # If WiFi is connected, display the WiFi SSID with first 2 and last 2 characters
    wifi_name_lower=$(echo "$wifi_name" | tr '[:upper:]' '[:lower:]')

    if [[ "$wifi_name_lower" == *"5g"* ]]; then
            wifi_status="$(echo "$wifi_name" | awk '{print substr($0, 1, 2)}')5G"
    else
            wifi_status="$(echo "$wifi_name" | awk '{print substr($0, 1, 4)}')"
    fi

    # Get WiFi speed (using iw command)
    wifi_speed=$(iw dev wlan0 link | grep 'bitrate' | awk '{print $3 " " substr($4,0,2) "/s"}')
    echo "無線 $wifi_status $wifi_speed"
    # echo GREEN
else
        # If no WiFi is connected, check for Ethernet connection
        # if nmcli dev status | grep -q 'ethernet' && nmcli dev status | grep -q 'connected'; then
        #     speed=$(ethtool eth0 | grep 'Speed' | awk '{print $2}')
        #     echo "有線$speed"
        # else
        # If neither WiFi nor Ethernet is connected, print "Disconnected"
        echo "切断"
        # fi
fi
