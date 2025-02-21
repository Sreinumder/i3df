#!/bin/bash

# Function to get WiFi signal strength (1 digit)
get_wifi_signal_strength() {
    local interface="$1"
    # Get signal strength in dBm using iw
    local signal=$(iw dev "$interface" link | grep 'signal' | awk '{print $2}')
    
    # Convert signal strength to a single-digit quality indicator (0-9)
    if [ -n "$signal" ]; then
        # Normalize signal strength (typically ranges from -30 dBm to -90 dBm)
        local quality=$(( (signal + 100) * 10 / 70 ))
        # Clamp the value between 0 and 9
        [[ $quality -lt 0 ]] && quality=0
        [[ $quality -gt 9 ]] && quality=9
        echo "$quality"
    else
        echo "-"
    fi
}

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

    # Detect WiFi interface dynamically
    wifi_interface=$(iw dev | awk '$1=="Interface"{print $2}' | head -n 1)

    # Get WiFi speed (using iw command)
    wifi_speed=$(iw dev "$wifi_interface" link | grep 'bitrate' | awk '{print $3 " " substr($4, 0, 2) "/s"}')

    # Get WiFi signal strength (1 digit)
    wifi_signal=$(get_wifi_signal_strength "$wifi_interface")

    # Output WiFi status, speed, and signal strength
    echo "無線 $wifi_status $wifi_speed ($wifi_signal)"
else
    # If no WiFi is connected, check for Ethernet connection
    if nmcli dev status | grep -q 'ethernet' && nmcli dev status | grep -q 'connected'; then
        # Get Ethernet speed
        eth_interface=$(nmcli dev status | grep 'ethernet' | grep 'connected' | awk '{print $1}')
        speed=$(ethtool "$eth_interface" 2>/dev/null | grep 'Speed' | awk '{print $2}')
        echo "有線 $speed"
    else
        # If neither WiFi nor Ethernet is connected, print "Disconnected"
        echo "切断"
    fi
fi
