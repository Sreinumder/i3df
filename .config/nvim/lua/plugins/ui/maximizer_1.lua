return {
	"szw/vim-maximizer",
	keys = {
		{ mode = "n", "<leader>mt", "<cmd>MaximizerToggle<CR>", { desc = "toggle maximize " } },
		{ mode = "x", "<leader>mt", "<cmd>MaximizerToggle<CR>gv", { desc = "toggle maximize " } },
	},
}
