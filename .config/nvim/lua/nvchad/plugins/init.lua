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
		config = function()
			require("nvchad")
		end,
	},

	"nvzone/volt",
}
