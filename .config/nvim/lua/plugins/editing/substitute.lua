return {
	"gbprod/substitute.nvim",
	keys = {
		{ mode ="n", "s", function() require("substitute").operator() end, { noremap = true } },
		{ mode ="n", "ss", function() require("substitute").line() end, { noremap = true } },
		{ mode ="n", "S", function() require("substitute").eol() end, { noremap = true } },
		{ mode ="x", "s", function() require("substitute").visual() end, { noremap = true } },
		{ mode ="n", "<A-s>", function() require("substitute.exchange").operator() end, { noremap = true } },
		{ mode ="n", "<A-s><A-s>", function() require("substitute.exchange").line() end, { noremap = true } },
		{ mode ="x", "<A-s>", function() require("substitute.exchange").visual() end, { noremap = true } },
		{ mode ="n", "<A-s>c", function() require("substitute.exchange").cancel() end, { noremap = true } },
		{ mode ="n", "<A-S>", function() require("substitute.range").operator() end, { noremap = true } },
		{ mode ="x", "<A-S>", function() require("substitute.range").visual() end, { noremap = true } },
		{ mode ="n", "<A-S>sr", function() require("substitute.range").word() end, { noremap = true } },
	},
	opts = {
		yank_substituted_text = false,
		preserve_cursor_position = false,
		highlight_substituted_text = { enabled = true, timer = vim.g.change_hl_duration },
		range = { cursor_position = "end" },
		exchange = { preserve_cursor_position = true },
	},
}
