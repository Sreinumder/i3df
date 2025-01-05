return {
	"uga-rosa/ccc.nvim",
	-- event = "BufEnter",
	ft = { "html", "css", "js", "config", "conf" },
	keys = {
		{
			"<leader>ccc",
			":CccPick<CR>",
			{ desc = "ccc pick" },
		},
		{
			"<leader>c<C-a>",
			":CccConvert<CR>",
			{ desc = "ccc convert" },
		},
		{
			",cc",
			":CccHighlighterToggle<CR>",
			{ desc = "ccc toggle" },
		},
	},
	opts = {
		highlighter = {
			auto_enable = true,
			lsp = true,
		},
	},
}
-- #11ac7922
-- #c6b493
