-- opens a seperate buffer for editing like comments or markdown code
return {
	"monaqa/nvim-treesitter-clipping",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"thinca/vim-partedit",
	},
	keys = {
		{
			"<localleader>c",
			"<Plug>(ts-clipping-clip)",
			desc = "Clip",
			mode = { "n" },
		},
		{
			"<localleader>c",
			"<Plug>(ts-clipping-select)",
			desc = "Clip Select",
			mode = { "x", "o" },
		},
	},
}
