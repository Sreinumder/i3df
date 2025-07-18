#!/bin/bash

# Handle mouse clicks lmr click  scroll up and down
case $BLOCK_BUTTON in
    1) ~/i3df/scripts/doing.sh done;;
    2) ~/i3df/scripts/doing.sh undo;;
    3) wezterm -e ~/i3df/scripts/doing.sh edit;;
    4) ~/i3df/scripts/doing.sh next-file;;
    5) ~/i3df/scripts/doing.sh next-do;;
esac

~/i3df/scripts/doing.sh show
