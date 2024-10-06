--┌────────────────────────────────────────────────────────────────────────┐
--│gives current position inside some scope of a class or object to incline│
--│and incline shows it in top corner                                      │
--└────────────────────────────────────────────────────────────────────────┘
return {
	"SmiteshP/nvim-navic",
	dependencies = "neovim/nvim-lspconfig",
	config = function()
		local navic = require("nvim-navic")
		require("lspconfig").clangd.setup({
			on_attach = function(client, bufnr)
				navic.attach(client, bufnr)
			end,
		})
	end,
}
