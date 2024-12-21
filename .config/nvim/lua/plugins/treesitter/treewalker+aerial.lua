return {
  {
    "aaronik/treewalker.nvim",
    opts = {
      highlight = true, -- Whether to briefly highlight the node after jumping to it
      highlight_duration = 250, -- How long should above highlight last (in ms)
    },
    keys = {
      {'<C-j>', ':Treewalker Down<CR>', { noremap = true }},
      {'<C-k>', ':Treewalker Up<CR>', { noremap = true }},
      {'<C-h>', ':Treewalker Left<CR>', { noremap = true }},
      {'<C-l>', ':Treewalker Right<CR>', { noremap = true }},
    }
  },
	{
	  'stevearc/aerial.nvim',
	  opts = {},
	  keys = {
      {"<A-,>", "<cmd>AerialToggle!<CR>"},
      -- {"<A-->", "<cmd>AerialPrev<CR>"},
      -- {"<A-=>", "<cmd>AerialNext<CR>"},
    },
	  dependencies = {
	    "nvim-treesitter/nvim-treesitter",
	    "nvim-tree/nvim-web-devicons"
	  },
	},
}
