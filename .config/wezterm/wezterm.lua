local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.color_scheme = 'Everblush (Gogh)'
-- config.color_scheme = 'AdventureTime'
-- config.font = wezterm.font 'Fira Code'
-- config.font = wezterm.font 'Iosevka Nerd Font'
config.font = wezterm.font_with_fallback {
  'Iosevka Nerd Font',
  'Monotty',
}
-- config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, --disable ligature
-- config.font = wezterm.font_with_fallback { 'Fira Code', }
config.font_size = 10.0
config.line_height = 1.0
config.hide_tab_bar_if_only_one_tab = true
config.use_dead_keys = false
config.use_ime = true
config.window_background_opacity = 0.9
config.warn_about_missing_glyphs = false
config.window_padding = {
  left   = 0,
  right  = 0,
  top    = 0,
  bottom = 0,
}

local io = require 'io'
local os = require 'os'
local act = wezterm.action

wezterm.on('trigger-nvim-with-scrollback', function(window, pane)
  local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)
  local name = os.tmpname()
  local f = io.open(name, 'w+')
  f:write(text)
  f:flush()
  f:close()
  window:perform_action(
    act.SpawnCommandInNewWindow {
      args = { 'nvim', name },
    },
    pane
  )
  wezterm.sleep_ms(1000)
  os.remove(name)
end)

  config.keys = { {
      key = 'E',
      mods = 'CTRL',
      action = act.EmitEvent 'trigger-nvim-with-scrollback',
    },
  }
return config
