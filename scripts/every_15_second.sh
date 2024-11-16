#!/bin/bash

prev_status="N/A"
while sleep 1;
do date > ~/a.txt 
  if [[ $(cat /sys/class/power_supply/BAT0/status) != "Charging" ]]; then 
    echo "not charging "
    if [[ $(cat /sys/class/power_supply/BAT0/capacity) -le 10 ]]; then
      echo "less than 10"
      notify-send -u critical "BAT0 <= 10%. plug it in."
    fi
    if [[ $prev_status == "charging" ]]; then
      notify-send -u normal "discharging"
      mpv ~/i3df/scripts/notify/charge_out_choir.mp3 &
    fi
    prev_status="not_charging"
  else
    if [[ $prev_status == "not_charging" ]]; then
      mpv ~/i3df/scripts/notify/charge_in_choir.mp3 &
      notify-send -u normal "charging"
    fi
    prev_status="charging"
    echo "we chillin"
  fi
done
done
