return {
	"kevinhwang91/nvim-bqf",
  event = "FileType qf",
  keys = {
    -- {"<A-q>", "<cmd>BqfToggle<CR>", desc = "bqf-toggle"},
    {"<leader>qf", "<cmd>copen<CR>", desc = "quickfix-op"},
  },
  opts = {},
	dependencies = {
		"stevearc/quicker.nvim",
		opts = {
			opts = {
				-- buflisted = false,
				number = true,
				relativenumber = true,
				wrap = false,
			},
			keys = {
				{ "<A-<>", "<cmd>lua require('quicker').toggle_expand()<CR>", desc = "Expand quickfix content" },
			},
			constrain_cursor = true,
			follow = { enabled = true, }, -- When quickfix window is open, scroll to closest item to the cursor
			borders = {
				vert = "|",
				strong_header = "-",
				strong_cross = "+",
				strong_end = ">",
				soft_header = "_",
				soft_cross = "*",
				soft_end = ">",
			},
		},
	},
}
