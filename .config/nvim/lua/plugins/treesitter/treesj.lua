return {
	"Wansmer/treesj",
	dependencies = {"nvim-treesitter/nvim-treesitter"},
	opts = {},
	keys = { { "<space>m", ":lua require('treesj').toggle()", { desc = "split-join" } } },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
}
