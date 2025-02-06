return {
	"uga-rosa/ccc.nvim",
	-- event = "BufEnter",
	ft = { "html", "css", "js", "config", "conf" },
	keys = {
		{
			"<leader>acp",
			":CccPick<CR>",
			 desc = "ccc pick" ,
		},
		{
			"<leader>a<C-a>",
			":CccConvert<CR>",
			 desc = "ccc convert" ,
		},
		{
			"<leader>,cc",
			":CccHighlighterToggle<CR>",
			 desc = "ccc toggle" ,
		},
	},
	opts = {
		highlighter = {
			auto_enable = true,
			lsp = true,
		},
	},
}
-- #11ac7821
-- #c6b493
