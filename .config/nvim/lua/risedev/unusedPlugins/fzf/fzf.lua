return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true } },
		{ "<leader>fc", "<cmd>lua require('fzf-lua').colorschemes()<CR>", { silent = true } },
		{ "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true } },
		{ "n", "<leader>fg", "<cmd>lua require('fzf-lua').git()<CR>", { silent = true } },
	},
	opts = {},
}
