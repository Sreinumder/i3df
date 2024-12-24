local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.color_scheme = "Everblush (Gogh)"
-- config.color_scheme = 'AdventureTime'
-- config.font = wezterm.font 'Fira Code'
-- config.font = wezterm.font 'Iosevka Nerd Font'
config.font = wezterm.font_with_fallback({
	"Iosevka Nerd Font",
	-- "Monotty",
})
-- config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, --disable ligature
-- config.font = wezterm.font_with_fallback { 'Fira Code', }
config.enable_kitty_graphics = true
config.font_size = 11.0
config.line_height = 1.0
-- config.hide_tab_bar_if_only_one_tab = true
config.use_dead_keys = false
config.use_ime = false
config.window_background_opacity = 0.9
config.warn_about_missing_glyphs = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
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
					direction = "Right",
					size = 0.4,
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
}

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config, {
	direction_keys = { "h", "j", "k", "l" },
	modifiers = {
		move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
		resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
	},
	log_level = "info",
})
bar.apply_to_config(config)

return config
