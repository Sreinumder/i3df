#!/bin/bash

# Get RAM usage
ram_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
ram_free=$(grep MemFree /proc/meminfo | awk '{print $2}')
ram_buffers=$(grep Buffers /proc/meminfo | awk '{print $2}')
ram_cached=$(grep '^Cached' /proc/meminfo | awk '{print $2}')

# Calculate used RAM
ram_used=$((ram_total - ram_free - ram_buffers - ram_cached))

# Avoid division by zero
if [[ $ram_total -eq 0 ]]; then
    echo "RAM: N/A"
    exit 0
fi

# Calculate RAM usage percentage
ram_usage=$(echo "scale=2; ($ram_used * 100 / $ram_total)" | bc -l)
ram_usage_percent=$(printf "%.2f%%" $ram_usage)

# Determine color based on RAM usage (using RGB values)
if (( $(echo "$ram_usage >= 90" | bc -l) )); then
    # Red for critical usage (>= 90%)
    color="#FF4D4D"  # Light red
elif (( $(echo "$ram_usage >= 80" | bc -l) )); then
    # Yellow for moderate usage (>= 80% but < 90%)
    color="#FFD700"  # Gold
else
    # Green for normal usage (< 80%)
    color="#FFFFFF"  # Pure White
fi

# Output for i3blocks with Pango markup
echo "<span foreground='$color'>メモリ $ram_usage_percent</span>"
