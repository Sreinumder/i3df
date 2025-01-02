return {
	{
		"aaronik/treewalker.nvim",
		dependencies = { "smoka7/hydra.nvim" },
		opts = {
			highlight = true, -- Whether to briefly highlight the node after jumping to it
			highlight_duration = 250, -- How long should above highlight last (in ms)
		},
		keys = {
			{ mode = { "n" }, "<C-h>", ":Treewalker Left<CR>", { noremap = true } },
			{ mode = { "n" }, "<C-j>", ":Treewalker Down<CR>", { noremap = true } },
			{ mode = { "n" }, "<C-k>", ":Treewalker Up<CR>", { noremap = true } },
			{ mode = { "n" }, "<C-l>", ":Treewalker Right<CR>", { noremap = true } },
			{ mode = { "x" }, "<C-h>", "<ESC>:Treewalker Left<CR>mtgv't", { noremap = true } },
			{ mode = { "x" }, "<C-j>", "<ESC>:Treewalker Down<CR>mtgv't", { noremap = true } },
			{ mode = { "x" }, "<C-k>", "<ESC>:Treewalker Up<CR>mtgv't", { noremap = true } },
			{ mode = { "x" }, "<C-l>", "<ESC>:Treewalker Right<CR>mtgv't>", { noremap = true } },
			-- { "<A-h>", ":TSTextobjectSwapPrevious @parameter.inner<CR>", { noremap = true, silent = true } },
			{ "<C-A-j>", "<cmd>Treewalker SwapDown<cr>", { noremap = true, silent = true } },
			{ "<C-A-k>", "<cmd>Treewalker SwapUp<cr>", { noremap = true, silent = true } },
			-- { "<A-l>", ":TSTextobjectSwapNext @parameter.inner<CR>", { noremap = true, silent = true } },
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
