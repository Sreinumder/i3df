return {
	"Wansmer/treesj",
	opts = {},
	keys = {
    { "<M-m>", function() require("treesj").toggle() end, { desc = "split-join" } },
  },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
}
