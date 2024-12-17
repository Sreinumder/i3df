return {
  "NeogitOrg/neogit",
  event = "UIEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
  },
	keys = {
		{
			"<leader>gg",
			function()
				require("neogit").open({})
			end,
			desc = "Open Neogit in floating window",
		},
		{
			"<leader>gc",
			function()
				require("neogit").open({ "commit" })
			end,
			desc = "Open Neogit commit window",
		},
	},
  config = true
}
