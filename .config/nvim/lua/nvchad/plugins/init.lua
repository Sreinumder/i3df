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
      vim.keymap.set({ "n", "x" }, "<leader>,ct", function()
        require('base46').toggle_theme()
      end, {desc = "transparency toggle"})
      vim.keymap.set({ "n", "x" }, "<leader>,tt", function()
        require('base46').toggle_transparency()
      end, {desc = "transparency toggle"})
    end,
  },
  "nvzone/volt",
}
