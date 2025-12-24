#!/bin/bash

case $BLOCK_BUTTON in
  1)
    gnome-clocks
    ;;
esac
time=$(date '+%H:%M')
echo $time
