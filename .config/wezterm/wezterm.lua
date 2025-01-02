local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.color_scheme = "Everblush (Gogh)"
-- config.color_scheme = 'AdventureTime'
-- config.font = wezterm.font 'Fira Code'
-- config.font = wezterm.font 'Iosevka Nerd Font'
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Iosevka Nerd Font",
	-- "Monotty",
})
-- config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, --disable ligature
-- config.font = wezterm.font_with_fallback { 'Fira Code', }
config.enable_kitty_graphics = true
config.font_size = 11.0
config.line_height = 0.9
-- config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_dead_keys = false
config.use_ime = true
config.window_background_opacity = 0.9
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
	font_size = 9.0,
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
					size = 0.5,
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
		mods = "ALT",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = "Tab",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "Tab",
		mods = "CTRL",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{ key = "Tab", mods = "ALT", action = act.ActivateTabRelative(1) },
	{ key = "Tab", mods = "SHIFT|ALT", action = act.ActivateTabRelative(-1) },
	{ key = "Q", mods = "SHIFT|ALT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
	{ key = "W", mods = "SHIFT|ALT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	{ key = "V", mods = "SHIFT|ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "S", mods = "SHIFT|ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "t", mods = "SHIFT|ALT", action = act.SpawnTab("CurrentPaneDomain") },
}
for i = 1, 7 do -- CTRL+ALT + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "ALT|SHIFT",
		action = act.ActivateTab(i - 1),
	})
	-- table.insert(config.keys, {
	-- 	key = tostring(i),
	-- 	mods = "CTRL|SHIFT",
	-- 	action = wezterm.action.DisableDefaultAssignment,
	-- })
	-- F1 through F8 to activate that tab
	table.insert(config.keys, {
		key = "F" .. tostring(i),
		action = act.ActivateTab(i - 1),
	})
end
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config)

config.colors = {
	tab_bar = {
		background = "#181f22",
		active_tab = {
			bg_color = "#262d30",
			fg_color = "#eeeeee",
			intensity = "Bold",
			underline = "None",
			italic = true,
			strikethrough = false,
		},
		inactive_tab = {
			bg_color = "#181f22",
			fg_color = "#eeeeee",
		},
		inactive_tab_hover = {
			bg_color = "#3b3052",
			fg_color = "#eeeeee",
			italic = false,
		},
		new_tab = {
			bg_color = "#181f22",
			fg_color = "#eeeeee",
		},
		new_tab_hover = {
			bg_color = "#282f32",
			fg_color = "#eeeeee",
			italic = false,
		},
	},
}

return config
