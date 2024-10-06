--┌──────────────────────────────────┐
--│<leader>,t  to toggle transparency│
--└──────────────────────────────────┘
return {
	"xiyaowong/transparent.nvim",
	opts = { -- Optional, you don't have to run setup.
		groups = {
			"Normal",
			"NormalNC",
			"Comment",
			"Constant",
			"Special",
			"Identifier",
			"Statement",
			"PreProc",
			"Type",
			"Underlined",
			"Todo",
			"String",
			"Function",
			"Conditional",
			"Repeat",
			"Operator",
			"Structure",
			"LineNr",
			"NonText",
			"SignColumn",
			"CursorLine",
			"CursorLineNr",
			"StatusLine",
			"StatusLineNC",
			"EndOfBuffer",
		},
		extra_groups = {}, -- table: additional groups that should be cleared
		exclude_groups = {}, -- table: groups you don't want to clear
	},
	cmd = "TransparentToggle",
	keys = {
    { "<leader>,t", ":TransparentToggle<CR>", { desc = "toggle transparency" }},
  },
}
