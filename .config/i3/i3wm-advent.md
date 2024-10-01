* autostart.sh 
    ** edit .dmrc
    ```
        [Desktop Entry]
        Name=Custom Session
        Exec= ~/.autostart
        Type=Application

        # then
        touch ~/.autostart
        chmod +x ~/.autostart
    ```

* Installed yay
```
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```

* I fixed touchpad tapping and natural scrolling by simply editing/creating the libinput conf file at:
    cat /etc/X11/xorg.conf.d/30-touchpad.conf
    ```
        Section "InputClass"
            Identifier "touchpad"
            Driver "libinput"
            MatchIsTouchpad "on"
            Option "Tapping" "on"
            Option "TappingButtonMap" "lrm"
            Option "NaturalScrolling" "true"
        EndSection
    ```

* Swap escape<->caps
cat /etc/X11/xorg.conf.d/00-keyboard.conf
    ```
        Section "InputClass"
                Identifier "system-keyboard"
                MatchIsKeyboard "on"
                Option "XkbLayout" "us"
                Option "XkbModel" "pc105+inet"
                Option "XkbOptions" "caps:swapescape, terminate:ctrl_alt_bksp"
        EndSection
    ```

* Brighness and media binding
** Installed brightnessctl
```
    pacman -S brightnessctl
```
```
    bindsym XF86MonBrightnessUp exec brighnessctl set +2%
    bindsym XF86MonBrightnessDown exec brighnessctl set 2%-
    bindsym XF86AudioPlay  exec playerctl play-pause
    bindsym Shift+XF86AudioPlay  exec playerctl stop
    bindsym Ctrl+XF86AudioPlay  exec playerctl play-pause -a
    bindsym XF86AudioPause exec playerctl pause
    bindsym XF86AudioNext  exec playerctl next
    bindsym XF86AudioPrev  exec playerctl previous
```

* Clipboard management through clipmenu
```
    sudo pacman -S clipmenu
    # on .xinitrc
    systemctl --user import-environment DISPLAY  # for clipmenu
    clipmenud &
```


* Configure japanese locale, font and input
** To change/add locale:
```
    sudo nvim /etc/locale.gen
    uncomment ja_JP.UTF-8 UTF-8 and save.
    run sudo locale-gen
```

** Installed japanese font
sudo pacman -S adobe-source-han-serif-jp-fonts adobe-source-han-sans-jp-fonts

** Installed fcitx5
```
    yay -S fcitx5
```

* Set dark mode preference
in bashrc
```
    export QT_STYLE_OVERRIDE=Adwaita-Dark # dark mode
```
