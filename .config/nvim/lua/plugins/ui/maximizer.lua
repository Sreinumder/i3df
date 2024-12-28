return {
	"szw/vim-maximizer",
	keys = {
		{ mode = "n", "<leader>mt", ":MaximizerToggle<CR>", { desc = "toggle maximize " } },
		{ mode = "x", "<leader>mt", ":MaximizerToggle<CR>gv", { desc = "toggle maximize " } },
		-- {mode="i", "<leader>mt", "<C-o>:MaximizerToggle<CR>", {desc = "toggle maximize "}}
	},
}
