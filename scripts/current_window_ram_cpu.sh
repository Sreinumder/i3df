#!/bin/bash

case $BLOCK_BUTTON in
    1)
      pkill dmenu; dmenu_run -m 0 -fn 'Jetbrains Mono-11'
      ;;
    4)
        ~/i3df/scripts/window_cycle.sh next
        ;;
    5)
        ~/i3df/scripts/window_cycle.sh previous
        ;;
esac

# Function to recursively find all child PIDs of a given PID
get_all_child_pids() {
    local pid=$1
    local pids="$pid"  # Start with the current PID
    local children

    # Find all direct children of the current PID
    children=$(pgrep -P "$pid" || true)

    # Recursively find children of each child
    for child in $children; do
        pids+=" $(get_all_child_pids "$child")"
    done

    echo "$pids"
}

# Function to get the total RAM usage of a process and its children
get_total_ram_usage() {
    local pid=$1
    local total_ram=0
    local seen_pids=()

    # Get all PIDs in the process tree (including the parent)
    all_pids=$(get_all_child_pids "$pid")

    # Sum up the RAM usage of all unique PIDs
    for pid in $all_pids; do
        if [[ ! " ${seen_pids[@]} " =~ " $pid " ]] && [[ -f /proc/$pid/status ]]; then
            ram_kb=$(grep VmRSS /proc/$pid/status | awk '{print $2}')
            total_ram=$((total_ram + ram_kb))
            seen_pids+=("$pid")
        fi
    done

    echo "$total_ram"
}

if [[ "$XDG_SESSION_TYPE" == "wayland" ]] && [[ "$SWAYSOCK" ]]; then
    pid=$(swaymsg -t get_tree | jq '.. | select(.type? == "con" and .focused == true) | .pid')
    id=$(swaymsg -t get_tree | jq '.. | select(.type? == "con" and .focused == true) | .id')
else
    window_id=$(xprop -root _NET_ACTIVE_WINDOW | awk '{print $5}')
    if [[ "$window_id" == "0x0" || -z "$window_id" ]]; then # Check if a valid window ID was found
        echo "窓がない"
        exit 0
    fi
    pid=$(xprop -id "$window_id" _NET_WM_PID | awk '{print $3}')
fi

# Check if a valid PID was found
if [[ -z "$pid" || "$pid" == "0" ]]; then
    echo "||"
    exit 0
fi

# Get the binary name of the process
binary_name=$(cat /proc/$pid/comm)

# Get the first two letters of the binary name
binary_short=$(echo "$binary_name" | cut -c1-2)

# Get the total RAM usage of the process and its children
total_ram_kb=$(get_total_ram_usage "$pid")
total_ram_mb=$(echo "scale=0; $total_ram_kb / 1024" | bc)

# Output the result
echo "${binary_short}:${total_ram_mb}M"
