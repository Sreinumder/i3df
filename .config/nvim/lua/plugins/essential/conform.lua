return {
	"stevearc/conform.nvim",
	-- event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>ef",
			function()
				require("conform").format()
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			toml = {  "prettier"  },
			javascript = { { "prettierd", "prettier" } },
			typescript = { { "prettierd", "prettier" } },
			javascriptreact = { { "prettier", "prettierd" } },
			typescriptreact = { { "prettier", "prettierd" } },
			css = { { "prettierd", "prettier" } },
			html = { { "prettierd", "prettier" } },
			c = { { "prettierd", "prettier" } },
			cpp = { { "ast-grep " } },
		},
		-- Set up format-on-save
		-- format_on_save = { timeout_ms = 500, lsp_fallback = true },
		-- Customize formatters
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
		},
	},
	-- init = function()
	-- If you want the formatexpr, here is the place to set it
	-- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	-- end,
}
