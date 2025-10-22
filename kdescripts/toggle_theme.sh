#!/bin/bash

# Check current color scheme from kdeglobals
current_scheme=$(kreadconfig6 --file kdeglobals --group General --key ColorScheme)

if [ "$current_scheme" = "BreezeLight" ]; then
    plasma-apply-lookandfeel -a org.kde.breezedark.desktop
    konsoleprofile "ColorScheme=BlackOnWhite"
else
    plasma-apply-lookandfeel -a org.kde.breeze.desktop
    konsoleprofile "ColorScheme=WhiteOnBlack"
fi
