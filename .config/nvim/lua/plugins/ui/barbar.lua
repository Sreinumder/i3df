return {
	"romgrk/barbar.nvim",
	-- event = "UIEnter",
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	opts = {
		insert_at_end = true, -- new tab to right
		animation = true,
		separator = { left = " ", right = "" },
		modified = { button = "●" },
		pinned = { button = "", filename = true },
		-- …etc.
	},
	keys = {
		{ "<Tab>", "<Cmd>BufferNext<CR>", { desc = "buffer next" } },
		{ "<S-Tab>", "<Cmd>BufferPrevious<CR>", { desc = "buffer prev" } },
		{ "<C-Tab>", "<Cmd>BufferMoveNext<CR>", { desc = "buffer move right" } },
		{ "<C-S-Tab>", "<Cmd>BufferMovePrevious<CR>", { desc = "buffer move left" } },
		{ "<A-w>", "<Cmd>BufferWipeout<CR>", { desc = "buffer close" } },
		{ "<A-W>", "<Cmd>BufferRestore<CR>", { desc = "buffer restore" } },
		{ "<leader><tab>", "<Cmd>BufferPick<CR>", { desc = "buffer pick" } },
		{ "<leader><A-w>", "<Cmd>BufferPickDelete<CR>", { desc = "buffer pick delete" } },
		{ "<C-w>1", "<Cmd>BufferGoto 1<CR>", { desc = "goto tab 1" } },
		{ "<C-w>2", "<Cmd>BufferGoto 2<CR>", { desc = "goto tab 2" } },
		{ "<C-w>3", "<Cmd>BufferGoto 3<CR>", { desc = "goto tab 3" } },
		{ "<C-w>4", "<Cmd>BufferGoto 4<CR>", { desc = "goto tab 4" } },
		-- { "<localleader>b", "<Cmd>BufferPin<CR>", { desc = "buffer pin" } },
		-- { "<leader>b", "<Cmd>BufferGotoPinned<CR>", { desc = "buffer pinned" } },
		-- { "<localleader>bpp", "<Cmd>BufferGotoUnpinned<CR>", { desc = "buffer unpinned" } },

		--            :BufferCloseAllButCurrent
		--            :BufferCloseAllButVisible
		--            :BufferCloseAllButPinned
		--            :BufferCloseAllButCurrentOrPinned
		--            :BufferCloseBuffersLeft
		--            :BufferCloseBuffersRight
	},
}
