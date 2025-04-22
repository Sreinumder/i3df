fixing stuff
============

touchpad and keyboard (swap escape capslock)
---------------------------------------------------
``` input "type:touchpad" {
        tap enabled         # enables click-on-tap
        tap_button_map lrm  # tap with 1 finger = left click, 2 fingers = right click, 3 fingers = middle click
        dwt enabled         # disable (touchpad) while typing
        dwtp enabled        # disable (touchpad) while track pointing
        natural_scroll enabled  # disables reverse scroll
    }
    input "type:keyboard" {
        xkb_options "caps:swapescape"
    }
```

screensharing
--------------------
``` yay -S xdg-desktop-portal-git xdg-desktop-portal-wlr-git ```
* pipewire is also should be installed. probably already is. try ```pipewire --version```

