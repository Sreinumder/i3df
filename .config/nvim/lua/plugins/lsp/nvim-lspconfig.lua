return {
	"neovim/nvim-lspconfig",
	event = "UIEnter",
	keys = {
		{
			"<leader>ds",
			function()
				vim.diagnostic.setloclist()
			end,
			{ desc = "LSP diagnostic loclist" },
		},
		{
			"gr",
			function()
				vim.lsp.buf.references()
			end,
			{ desc = "Show references" },
		},
		{
			"gd",
			function()
				vim.lsp.buf.definition()
			end,
			{ desc = "Go to lsp definition" },
		},
		{ "<Leader>gd", "gd" },
		{
			"gD",
			function()
				vim.lsp.buf.declaration()
			end,
			{ desc = "Go to lsp declaration" },
		},
		{ "<Leader>gD", "gD" },
		{
			"<leader>D",
			function()
				vim.lsp.buf.type_definition()
			end,
			{ desc = "Go to type definition" },
		},
		{
			"gi",
			function()
				vim.lsp.buf.implementation()
			end,
			{ desc = "Go to implementation" },
		},
		{ "<Leader>gi", "gi" },
		{
			"<leader>wi",
			function()
				vim.lsp.buf.add_workspace_folder()
			end,
			{ desc = "Insert workspace folder" },
		},
		{
			"<leader>wr",
			function()
				vim.lsp.buf.remove_workspace_folder()
			end,
			{ desc = "Remove workspace folder" },
		},
		{
			mode = { "n", "x" },
			"<leader>ca",
			function()
				vim.lsp.buf.code_action()
			end,
			{ desc = "Code action" },
		},
		-- {"<leader>wl", function()
		-- 	print(vim.inspect(vim.lsp.buf.list|workspace_folders()))
		-- end, { desc = "List workspace folders" }},
	},
	dependencies = { "saghen/blink.cmp" },
	opts = {
		servers = {
			lua_ls = {},
			-- clangd = {},
			-- css={}.
			-- emmet-language-server = {},
		},
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")
		for server, config in pairs(opts.servers) do
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			lspconfig[server].setup(config)
		end
	end,
}
