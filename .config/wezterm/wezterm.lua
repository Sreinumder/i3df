local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.color_scheme = 'Everblush (Gogh)'
-- config.color_scheme = 'AdventureTime'
-- config.font = wezterm.font 'Fira Code'
config.font = wezterm.font 'Iosevka Nerd Font'
-- config.font = wezterm.font_with_fallback { 'Fira Code', }
config.font_size = 12.0
config.line_height = 1.0
config.hide_tab_bar_if_only_one_tab = true
config.use_dead_keys = false
config.use_ime = true
return config
