return {
	"williamboman/mason.nvim",
	cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
	keys = {
		{ "<leader>M", "<cmd>Mason<CR>", { desc = "Lazy nvim" } },
	},
	opts = {
		PATH = "skip",
		ui = {
			icons = {
				package_pending = " ",
				package_installed = " ",
				package_uninstalled = " ",
			},
		},
		max_concurrent_installers = 10,
	},
	config = function()
		require('mason').setup()
		require('mason-lspconfig').setup({
			ensure_installed = { 'pyright' },
		})
	end,
}
