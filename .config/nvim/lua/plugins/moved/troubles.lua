return {
	"folke/trouble.nvim",
	enabled = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"<leader>tx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
	},
	opts = {}, -- for default options, refer to the configuration section for custom setup.
}
