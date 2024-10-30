#!/bin/bash
# existing_sequence=$(i3-msg -t get_workspaces | jq '.[].num')
existing_sequence=$(i3-msg -t get_tree | jq '.nodes[].nodes[] | select((.type == "con") and (.output != "__i3")) | .nodes[] | select(.nodes != [])' | jq '.name' | sed 's/"//g' ) 
# i3-msg -t get_tree | jq '.nodes[].nodes[] | select((.type == "con") and (.output != "__i3"))'
# echo $existing_sequence > ~/a.txt

# Find the first missing number
for i in $(seq 10); do
    if ! echo "$existing_sequence" | grep -q "\b$i\b"; then
        echo "$i"
        break
    fi
done
# echo "1"
