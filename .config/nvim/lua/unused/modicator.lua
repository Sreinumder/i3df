-- ┌────────────────────────────────────────────┐
-- │changes line number color according to mode │
-- └────────────────────────────────────────────┘
return {
	"mawkler/modicator.nvim",
	event = "ModeChanged",
	opts = {
		show_warnings = true,
		highlights = {
			-- Default options for bold/italic
			defaults = {
				bold = false,
				italic = false,
			},
		},
		integration = {
			lualine = {
				enabled = true,
				mode_section = nil,
				highlight = "bg",
			},
		},
	},
}
