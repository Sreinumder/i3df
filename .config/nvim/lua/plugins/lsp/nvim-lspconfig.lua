return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },
	enabled = true,
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{ "<leader>K", "K",  desc = "default K"  },
		{"<leader>ds", function() vim.diagnostic.setloclist() end, desc = "LSP diagnostic loclist" ,},
		-- {"gr", function() vim.lsp.buf.references() end, desc = "Show references" ,},
		{"gd", function() vim.lsp.buf.definition() end, desc = "Go to lsp definition" ,},
		{ "<Leader>gd", "gd" },
		{"gD", function() vim.lsp.buf.declaration() end, desc = "Go to lsp declaration" ,},
		{ "<Leader>gD", "gD" },
		{"<leader>D", function() vim.lsp.buf.type_definition() end, desc = "Go to type definition" ,},
		-- { "<leader>gi",function() vim.lsp.buf.implementation() end, desc = "Go to implementation" ,},
		{
			"<leader>wi",
			function()
				vim.lsp.buf.add_workspace_folder()
			end,
			 desc = "Insert workspace folder" ,
		},
		{
			"<leader>wr",
			function()
				vim.lsp.buf.remove_workspace_folder()
			end,
			 desc = "Remove workspace folder" ,
		},
		-- {mode = { "n", "x" }, "<leader>ac", function() vim.lsp.buf.code_action() end, desc = "Code action" ,},
		-- {"<leader>wl", function()
			-- 	print(vim.inspect(vim.lsp.buf.list|workspace_folders()))
			-- end,  desc = "List workspace folders" },
		},
		opts = {
			servers = {
				lua_ls = {},
				pyright = {},
				-- clangd = {},
				-- css={}.
				emmet_ls = {},
        gopls = {},
			},
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } }, -- Recognize the `vim` global (Neovim-specific)
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
					},
				},
			})
			lspconfig.emmet_ls.setup({
				filetypes = {
					"html",
					"css",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"vue",
					"svelte",
				},
				init_options = {
					html = {
						options = {
							["bem.enabled"] = true,
						},
					},
				},
			})
			lspconfig.pyright.setup({
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic", -- Options: off, basic, strict
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
				},
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }, -- Supports JS/TS/React
				cmd = { "typescript-language-server", "--stdio" },
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
			})
			lspconfig.eslint.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					-- Automatically fix problems on save
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
      })
      lspconfig.gopls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {"gopls"},
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        -- root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
      }
    end,
  }
