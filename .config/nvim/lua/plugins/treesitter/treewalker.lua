return {
	{
		"aaronik/treewalker.nvim",
		dependencies = { "smoka7/hydra.nvim" },
		opts = {
			highlight = true, -- Whether to briefly highlight the node after jumping to it
			highlight_duration = 250, -- How long should above highlight last (in ms)
		},
		keys = {
			{ mode = { "n" }, "<C-h>", "<cmd>Treewalker Left<CR>", { noremap = true } },
			{ mode = { "n" }, "<C-j>", "<cmd>Treewalker Down<CR>", { noremap = true } },
			{ mode = { "n" }, "<C-k>", "<cmd>Treewalker Up<CR>", { noremap = true } },
			{ mode = { "n" }, "<C-l>", "<cmd>Treewalker Right<CR>", { noremap = true } },
			{ mode = { "x" }, "<C-h>", "<ESC><cmd>Treewalker Left<CR>mtgv't", { noremap = true } },
			{ mode = { "x" }, "<C-j>", "<ESC><cmd>Treewalker Down<CR>mtgv't", { noremap = true } },
			{ mode = { "x" }, "<C-k>", "<ESC><cmd>Treewalker Up<CR>mtgv't", { noremap = true } },
			{ mode = { "x" }, "<C-l>", "<ESC><cmd>Treewalker Right<CR>mtgv't>", { noremap = true } },
			{ "<leader><C-A-j>", "<cmd>Treewalker SwapDown<cr>", { noremap = true, silent = true } },
			{ "<leader><C-A-k>", "<cmd>Treewalker SwapUp<cr>", { noremap = true, silent = true } },
			-- { "<leader>gh", ":TSTextobjectSwapPrevious @parameter.inner<CR>", { noremap = true, silent = true } },
			-- { "<leader>gl", ":TSTextobjectSwapNext @parameter.inner<CR>", { noremap = true, silent = true } },
		},
	},
	{
		"stevearc/aerial.nvim",
		opts = {},
		keys = {
			{ "<A-,>", "<cmd>AerialToggle!<CR>" },
			-- {"<A-->", "<cmd>AerialPrev<CR>"},
			-- {"<A-=>", "<cmd>AerialNext<CR>"},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-treesitter/nvim-treesitter-textobjects",
			-- "nvim-tree/nvim-web-devicons",
		},
	},
}
