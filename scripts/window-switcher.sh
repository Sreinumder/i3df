#!/bin/bash
swaymsg "[con_id=$(swaymsg -t get_tree| jq -r 'recurse(.nodes[]?) | recurse(.floating_nodes[]?) | select(.type=="con"), select(.type=="floating_con") | select((.app_id != null) or .name != null) | {id, app_id, name} | "\(.id) \(.app_id) \(.name)"' | dmenu | cut -d " " -f1 )]" focus
