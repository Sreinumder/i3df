return {
	"hedyhli/outline.nvim",
	keys = {
		{ "<leader>to", "<cmd>Outline<CR>", { desc = "Toggle Outline" } },
	},
	opts = {
		keymaps = {
			up_and_jump = "<A-k>",
			down_and_jump = "<A-j>",
		},
	},
}
