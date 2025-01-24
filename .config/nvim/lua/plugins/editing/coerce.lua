--┌─────────────────────────────────────────┐
--│changes naming convention-like camel case│
--│key bind prefix: co in visual mode       │
--└─────────────────────────────────────────┘
return {
	"gregorias/coerce.nvim",
	-- event = 'VeryLazy',
	dependencies = { "gregorias/coop.nvim" },
	keys = {
		{ "go", mode = { "v", "n" } },
	},
	config = function()
		require("coerce").setup({
			keymap_registry = require("coerce.keymap").keymap_registry(),
			-- The notification function used during error conditions.
			notify = function(...)
				return vim.notify(...)
			end,
			default_mode_keymap_prefixes = {
				normal_mode = "co",
				motion_mode = "go",
				visual_mode = "go",
			},
			-- Set any field to false to disable that mode.
			default_mode_mask = {
				normal_mode = true,
				motion_mode = true,
				visual_mode = true,
			},
			-- If you don’t like the default cases and modes, you can override them.
			-- cases = require"coerce".default_cases,
			-- modes = require"coerce".get_default_modes(default_mode_mask, default_mode_keymap_prefixes),
			-- print(default_mode_mask)
		})
	end,
}
