return {
	"romgrk/barbar.nvim",
	-- event = "UIEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		vim.g.barbar_auto_setup = false
	end,
	opts = {
		insert_at_end = true, -- new tab to right
    focus_on_close = 'left',
		animation = true,
		separator = { left = " ", right = "" },
		modified = { button = "●" },
		pinned = { button = "", filename = true },
    icons = { git = { enabled = true} },
		-- …etc.
	},
	keys = {
		{ "<Tab>", "<Cmd>BufferNext<CR>",  desc = "buffer next"  },
		{ "`", "<Cmd>BufferNext<CR>",  desc = "buffer next"  },
		{ "<S-Tab>", "<Cmd>BufferPrevious<CR>",  desc = "buffer prev"  },
		-- { "<leader>j", "<Cmd>BufferNext<CR>",  desc = "buffer right"  },
		-- { "<leader>k", "<Cmd>BufferPrevious<CR>",  desc = "buffer left"  },
		{ "<C-A-Tab>", "<Cmd>BufferMoveNext<CR>",  desc = "buffer move right"  },
		{ "<C-A-S-Tab>", "<Cmd>BufferMovePrevious<CR>",  desc = "buffer move left"  },
		{ "<A-w>", "<Cmd>BufferWipeout<CR>",  desc = "buffer close"  },
    { ";we", "<Cmd>BufferCloseAllButCurrent<CR>",  desc = "close except this"  },
		{ ";wh", "<Cmd>BufferCloseBuffersLeft<CR>",  desc = "close left"  },
		{ ";wl", "<Cmd>BufferCloseBuffersRight<CR>",  desc = "close right"  },
		{ "<A-W>", "<Cmd>BufferRestore<CR>",  desc = "buffer restore"  },
		{ "<leader><tab>", "<Cmd>BufferPick<CR>",  desc = "buffer pick"  },
		{ "<leader><A-w>", "<Cmd>BufferPickDelete<CR>",  desc = "buffer pick delete"  },
		-- { "<leader>1", "<Cmd>BufferGoto 1<CR>",  desc = "buffer 1"  },
		-- { "<leader>2", "<Cmd>BufferGoto 2<CR>",  desc = "buffer 2"  },
		-- { "<leader>3", "<Cmd>BufferGoto 3<CR>",  desc = "buffer 3"  },
		-- { "<leader>4", "<Cmd>BufferGoto 4<CR>",  desc = "buffer 4"  },
		--            :BufferCloseAllButCurrent
		--            :BufferCloseAllButVisible
		--            :BufferCloseAllButPinned
		--            :BufferCloseAllButCurrentOrPinned
		--            :BufferCloseBuffersLeft
		--            :BufferCloseBuffersRight
	},
  init = function()
      vim.api.nvim_set_hl(0, 'BufferCurrent', { fg = '#000000' })
  end,
}
