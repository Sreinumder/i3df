return {
	{
		"aaronik/treewalker.nvim",
		opts = {
			highlight = true, -- Whether to briefly highlight the node after jumping to it
			highlight_duration = 250, -- How long should above highlight last (in ms)
		},
		keys = {
			{ mode = { "n" }, "<C-Left>", ":Treewalker Left<CR>", { noremap = true } },
			{ mode = { "n" }, "<C-Down>", ":Treewalker Down<CR>", { noremap = true } },
			{ mode = { "n" }, "<C-Up>", ":Treewalker Up<CR>", { noremap = true } },
			{ mode = { "n" }, "<C-Right>", ":Treewalker Right<CR>", { noremap = true } },
			{ mode = { "x" }, "<C-Left>", "<ESC>:Treewalker Left<CR>mtgv't", { noremap = true } },
			{ mode = { "x" }, "<C-Down>", "<ESC>:Treewalker Down<CR>mtgv't", { noremap = true } },
			{ mode = { "x" }, "<C-Up>", "<ESC>:Treewalker Up<CR>mtgv't", { noremap = true } },
			{ mode = { "x" }, "<C-Right>", "<ESC>:Treewalker Right<CR>mtgv't>", { noremap = true } },
			{ "<A-Left>", ":TSTextobjectSwapPrevious @parameter.inner<CR>", { noremap = true, silent = true } },
			{ "<A-Down>", "<cmd>Treewalker SwapDown<cr>", { noremap = true, silent = true } },
			{ "<A-Up>", "<cmd>Treewalker SwapUp<cr>", { noremap = true, silent = true } },
			{ "<A-Right>", ":TSTextobjectSwapNext @parameter.inner<CR>", { noremap = true, silent = true } },
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
