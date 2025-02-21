#!/bin/bash

# Set locale to C to ensure consistent number formatting
export LC_ALL=C

# Read CPU stats from /proc/stat
read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat

# Calculate total CPU time and idle time
total=$((user + nice + system + idle + iowait + irq + softirq + steal))
idle_total=$((idle + iowait))

# Check if previous values exist (for delta calculation)
if [[ -f /tmp/prev_cpu_stats ]]; then
    # Read previous values
    read prev_total prev_idle_total < /tmp/prev_cpu_stats

    # Calculate deltas
    total_delta=$((total - prev_total))
    idle_delta=$((idle_total - prev_idle_total))

    # Avoid division by zero
    if [[ $total_delta -eq 0 ]]; then
        echo "CPU: N/A"
        exit 0
    fi

    # Calculate CPU usage percentage
    cpu_usage=$(echo "scale=2; (100 * ($total_delta - $idle_delta) / $total_delta)" | bc -l)
    cpu_usage_percent=$(printf "%.2f%%" $cpu_usage)
else
    # First run, no previous values available
    cpu_usage_percent="N/A"
fi

# Save current values for the next run
echo "$total $idle_total" > /tmp/prev_cpu_stats

# Determine color based on CPU usage (using RGB values)
if (( $(echo "$cpu_usage >= 90" | bc -l) )); then
    # Red for critical usage (>= 90%)
    color="#FF4D4D"  # Light red
elif (( $(echo "$cpu_usage >= 80" | bc -l) )); then
    # Yellow for moderate usage (>= 80% but < 90%)
    color="#FFD700"  # Gold
else
    # Green for normal usage (< 80%)
    color="#FFFFFF"  # Pure White
fi

# Output for i3blocks with Pango markup
if [[ "$cpu_usage_percent" == "N/A" ]]; then
    echo "CPU: N/A"
else
    echo "<span foreground='$color'>脳 $cpu_usage_percent</span>"
fi
