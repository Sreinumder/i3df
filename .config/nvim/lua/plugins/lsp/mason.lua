return {
	"williamboman/mason.nvim",
	cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
	keys = {
		{ "<leader>M", ":Mason<CR>", { desc = "Lazy nvim" } },
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
}
