local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- config.color_scheme = "OneHalfLight"
config.color_scheme = "Everblush"
config.font = wezterm.font_with_fallback({
  "JetBrains Mono",
  "Iosevka Nerd Font",
  "Nepali",
  -- "Monotty",
})
-- config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, --disable ligature
-- config.font = wezterm.font_with_fallback { 'Fira Code', }
config.enable_kitty_graphics = true
config.font_size = 12.0
config.line_height = 1.0
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_dead_keys = false
config.use_ime = true
config.window_background_opacity = 1
config.warn_about_missing_glyphs = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_frame = {
  font = wezterm.font_with_fallback({
    "JetBrains Mono",
    "Iosevka Nerd Font",
  }),
  font_size = 7.0,
  active_titlebar_bg = "#333333",
  inactive_titlebar_bg = "#333333",
}

local io = require("io")
local os = require("os")
local act = wezterm.action

wezterm.on("trigger-nvim-with-scrollback", function(window, pane)
  local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)
  local name = os.tmpname()
  local f = io.open(name, "w+")
  f:write(text)
  f:flush()
  f:close()
  window:perform_action(
  act.SpawnCommandInNewWindow({
    args = { "nvim", name },
  }),
  pane
  )
  wezterm.sleep_ms(1000)
  os.remove(name)
end)

config.disable_default_key_bindings = false
config.keys = {
  -- { key = "ctrl-space", mods = "NONE", action = wezterm.action.SendString("copied" .. "\n") }, -- Enter copy mode
  -- { key = "esc", mods = "NONE", action = wezterm.action.SendString("insert\n") }, -- Exit copy mode
  -- { key = "ctrl-shift-space", mods = "NONE", action = wezterm.action.SendString("pasted" .. "\n") }, -- Paste mode
  -- { key = "ctrl-f", mods = "NONE", action = wezterm.action.SendString("/\n") }, -- Search mode
  -- { key = "ctrl-g", mods = "NONE", action = wezterm.action.SendString("n\\") }, -- Find next
  -- { key = "alt-ctrl-g", mods = "NONE", action = wezterm.action.SendString("?\n") }, -- Find previous
  { key = "E", mods = "CTRL", action = act.EmitEvent("trigger-nvim-with-scrollback") },
  {
    key = "/",
    mods = "ALT",
    action = wezterm.action_callback(function(_, pane)
      local tab = pane:tab()
      local panes = tab:panes_with_info()
      if #panes == 1 then
        pane:split({
          -- direction = "Bottom",
          direction = "Right",
          size = 0.40,
        })
      elseif not panes[1].is_zoomed then
        panes[1].pane:activate()
        tab:set_zoomed(true)
      elseif panes[1].is_zoomed then
        tab:set_zoomed(false)
        panes[2].pane:activate()
      end
    end),
  },
  {
    key = "F2",
    mods = "CTRL",
    action = act.PromptInputLine({
      description = "Enter new name for tab",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
  {
    key = "f",
    mods = "ALT|SHIFT",
    action = wezterm.action.TogglePaneZoomState,
  },
  -- {
  --   key = "Tab",
  --   mods = "CTRL|SHIFT",
  --   action = wezterm.action.DisableDefaultAssignment,
  -- },
  -- {
  --   key = "Tab",
  --   mods = "CTRL",
  --   action = wezterm.action.DisableDefaultAssignment,
  -- },
  {
    key = "l",
    mods = "CTRL|SHIFT",
    action = wezterm.action.DisableDefaultAssignment,
  },
  { key = "Tab", mods = "ALT", action = act.ActivateTabRelative(1) },
  { key = "Tab", mods = "SHIFT|ALT", action = act.ActivateTabRelative(-1) },
  -- { key = "Q", mods = "SHIFT|ALT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
  { key = "Q", mods = "SHIFT|ALT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
  { key = "V", mods = "SHIFT|ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "S", mods = "SHIFT|ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "t", mods = "SHIFT|ALT", action = act.SpawnTab("CurrentPaneDomain") },
}

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
-- bar.apply_to_config(config)
bar.apply_to_config(config,{
  position = "bottom",
  max_width = 32,
  padding = {
    left = 1,
    right = 1,
  },
  separator = {
    space = 0,
    left_icon = ' ',
    right_icon = '',
    field_icon = '',
  },
  modules = {
    -- tabs = {
      --   active_tab_fg = 4,
      --   inactive_tab_fg = 6,
      -- },
      workspace = {enabled = false,},
      leader = {enabled = false,},
      pane = {enabled = false,},
      username = { enabled = false,
    },
    hostname = {enabled = false,},
    clock = {enabled = false,},
    cwd = {
      enabled = true,
      icon = '',
      color = 7,
    },
    spotify = {enabled = false,},
  },
})

-- local colorscheme = os.getenv("COLORSCHEME")
-- if colorscheme == "light" then
  -- config.colors = {
  --   cursor_bg = '#52ad70',
  --   background = "#fafafa", -- Light background
  --   foreground = "black", -- Dark text for contrast
  --   tab_bar = {
  --     background = "#fafafa", -- Light background
  --     active_tab = {
  --       bg_color = "#cccccc", -- Slightly darker than background for contrast
  --       fg_color = "#2c2c2c", -- Dark foreground
  --       intensity = "Bold",
  --       underline = "None",
  --       italic = true,
  --       strikethrough = false,
  --     },
  --     inactive_tab = {
  --       bg_color = "#f0f0f0", -- Light gray
  --       fg_color = "#5c5c5c", -- Medium gray for text contrast
  --     },
  --     inactive_tab_hover = {
  --       bg_color = "#dedede", -- Subtle hover effect
  --       fg_color = "#2c2c2c",
  --       italic = false,
  --     },
  --     new_tab = {
  --       bg_color = "#f0f0f0",
  --       fg_color = "#5c5c5c",
  --     },
  --     new_tab_hover = { 
  --       bg_color = "#dedede",
  --       fg_color = "#2c2c2c",
  --       italic = false,
  --     },
  --   }
  -- }
-- else
  config.colors = {
    cursor_bg = '#52ad70',
    tab_bar = {
      background = "#000000",
      active_tab = {
        bg_color = "#000000",
        fg_color = "#636b6f",
        intensity = "Bold",
        underline = "None",
        italic = true,
        strikethrough = false,
      },
      inactive_tab = {
        bg_color = "#000000",
        fg_color = "#333333",
      },
      inactive_tab_hover = {
        bg_color = "#dedede",
        fg_color = "#2c2c2c",
        italic = false,
      },
      new_tab = {
        bg_color = "#000000",
        fg_color = "#000000",
      },
      new_tab_hover = {
        bg_color = "#000000",
        fg_color = "#000000",
        italic = false,
      },
    }
  }
-- end

return config
