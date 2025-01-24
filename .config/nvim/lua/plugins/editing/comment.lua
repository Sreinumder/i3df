--┌───────────────────┐
--│Line gcc Block  gbc│
--│End of line     gcA│
--│Line Above      gcO│
--│Line below      gco│
--└───────────────────┘

return {
	-- {
	--    "numToStr/Comment.nvim",
	--    -- event = { "BufReadPre", "BufNewFile" },
	--    keys = {
	--    	{ "gc", mode = { "v", "n" } },
	--    	{ "gb", mode = { "v", "n" } },
	--    	{
	--    		"<C-/>",
	--    		function()
	--    			vim.api.nvim_feedkeys("<esc>", "nx", false)
	--    			require("Comment.api").toggle.linewise(vim.fn.visualmode())
	--    		end,
	--    		mode = { "x" },
	--    		desc = "toggle comment",
	--    	},
	--    },
	--    config = true,
	--    lazy = false,
	-- }.
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
}
