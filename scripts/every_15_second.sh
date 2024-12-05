#!/bin/bash

prev_status="N/A"
while sleep 15;
do
  if [[ $(cat /sys/class/power_supply/BAT0/status) != "Charging" ]]; then 
    echo "not charging $prev_status $(cat /sys/class/power_supply/BAT0/capacity)"
    if [[ $(cat /sys/class/power_supply/BAT0/capacity) -le 10 ]]; then
      if [[ $prev_status != "low" ]]; then
        notify-send -u critical "BAT0 <= 10%. plug it in."
        mpv ~/i3df/scripts/notify/charge_out_choir.mp3 &
        prev_status="low"
      fi
    fi
    if [[ $prev_status == "charging" ]]; then
      notify-send -u normal "discharging"
      mpv ~/i3df/scripts/notify/charge_out_choir.mp3 &
      prev_status="not_charging"
    fi
  else
    if [[ $prev_status != "charging" ]]; then
      mpv ~/i3df/scripts/notify/charge_in_choir.mp3 &
      notify-send -u normal "charging"
    fi
    prev_status="charging"
    echo "we chillin"
  fi
done
done
