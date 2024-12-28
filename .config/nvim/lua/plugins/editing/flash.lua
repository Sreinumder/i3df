return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			char = {
				enable = false,
				autohide = true,
				jump_labels = false,
				highlight = { backdrop = false },
			},
		},
	},
	keys = {
		{ "f" },
		{ "t" },
		{
			"<leader>;",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"R",
			mode = { "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"S",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		{
			"<A-f>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
		{
			"<A-8>",
			mode = { "n" },
			function()
				require("flash").jump({ pattern = vim.fn.expand("<cword>") })
			end,
			desc = "Toggle Flash Search",
		},
		-- { "tj", mode = { "n" }, function()
		--   require("flash").jump({
		--     search = { mode = "search", max_length = 0 },
		--     label = { after = { 0, 0 } },
		--     pattern = "^"
		--   })
		-- end, desc = "Toggle Flash Search" },
	},
}
