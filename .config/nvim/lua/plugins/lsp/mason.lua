return {
	"williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim"},
	cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
	keys = {
		{ "<leader>M", "<cmd>Mason<CR>",  desc = "Mason Menu"  },
	},
	opts = {
		PATH = "skip",
    border = "single",
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
			ensure_installed = {
        'pyright',
        'bash-language-server',
        'jsonlsp',
        'yaml-language-server',
        'lua-language-server',
        'html-lsp',
        'cssls',
        'tailwindcss-language-server',
        'typescript-language-server',
        'emmet-language-server',
        'cpplint',
        'ast-grep',
        'marksman',
      },
		})
	end,
}
