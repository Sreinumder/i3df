return {
	"Wansmer/treesj",
	opts = {},
	keys = { {
		"<leader>mm",
		function()
			require("treesj").toggle()
		end,
		{ desc = "split-join" },
	} },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
}
