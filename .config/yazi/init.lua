local catppuccin_theme = require("yatline-catppuccin"):setup("mocha") -- or "latte" | "frappe" | "macchiato"
require("yatline"):setup({ theme = catppuccin_theme })
require("relative-motions"):setup({ show_numbers = "relative-absolute", show_motion = true })
require("folder-rules"):setup()
require("git"):setup()
require("copy-file-contents"):setup({
	append_char = "\n",
	notification = true,
})
require("restore"):setup({
	-- Set the position for confirm and overwrite dialogs.
	-- don't forget to set height: `h = xx`
	-- https://yazi-rs.github.io/docs/plugins/utils/#ya.input
	position = { "center", w = 70, h = 40 },

	-- Show confirm dialog before restore.
	-- NOTE: even if set this to false, overwrite dialog still pop up
	show_confirm = true,

	-- colors for confirm and overwrite dialogs
	theme = {
		title = "blue",
		header = "green",
		-- header color for overwrite dialog
		header_warning = "yellow",
		list_item = { odd = "blue", even = "blue" },
	},
})
