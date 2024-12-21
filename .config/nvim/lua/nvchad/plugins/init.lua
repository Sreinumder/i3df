return {
	"nvim-lua/plenary.nvim",
	{
		"nvchad/base46",
		event = "UIEnter",
		config = function()
			require("base46").load_all_highlights()
		end,
	},

	{
		"nvchad/ui",
		event = "UIEnter",
		-- keys = {
		-- 	{ "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" } },
		-- 	{
		-- 		"<tab>",
		-- 		function()
		-- 			require("nvchad.tabufline").next()
		-- 		end,
		-- 		{ desc = "buffer goto next" },
		-- 	},
		-- 	{
		-- 		"<S-tab>",
		-- 		function()
		-- 			require("nvchad.tabufline").prev()
		-- 		end,
		-- 		{ desc = "buffer goto prev" },
		-- 	},
		-- 	{
		-- 		"<leader>xb",
		-- 		function()
		-- 			require("nvchad.tabufline").close_buffer()
		-- 		end,
		-- 		{ desc = "buffer close" },
		-- 	},
		-- 	{
		-- 		"<leader>th",
		-- 		function()
		-- 			require("nvchad.term").new({ pos = "sp" })
		-- 		end,
		-- 		{ desc = "terminal new horizontal term" },
		-- 	},
		-- 	{
		-- 		"<leader>tv",
		-- 		function()
		-- 			require("nvchad.term").new({ pos = "vsp" })
		-- 		end,
		-- 		{ desc = "terminal new vertical term" },
		-- 	},
		-- 	{
		-- 		{ "n", "t" },
		-- 		"<A-?>",
		-- 		function()
		-- 			require("nvchad.term").toggle({ pos = "vsp", id = "vtoggleTerm" })
		-- 		end,
		-- 		{ desc = "terminal toggleable vertical term" },
		-- 	},
		-- 	{
		-- 		{ "n", "t" },
		-- 		"<A-/>",
		-- 		function()
		-- 			require("nvchad.term").toggle({ pos = "sp", id = "htoggleTerm" })
		-- 		end,
		-- 		{ desc = "terminal toggleable horizontal term" },
		-- 	},
		-- },
		config = function()
			require("nvchad")
		end,
	},

	"nvzone/volt",
}
