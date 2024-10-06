return {
	"neovim/nvim-lspconfig",
	-- event = { "bufreadpre", "bufnewfile" },
	event = { "InsertEnter" },
	-- event = { "VeryLazy"},
	-- lazy = true,
	keys = {
		{ "<leader>M", ":Mason<CR>", { desc = "open mason" } },
	},
	dependencies = {
		{
			"williamboman/mason.nvim", -- easily install and manage lsp servers, dap servers, linters, and formatters.
		},
		{ "williamboman/mason-lspconfig.nvim" }, -- autocomplete
		{ "mfussenegger/nvim-lint" }, -- linter
		{
			"hrsh7th/nvim-cmp", -- A completion plugin for neovim coded in Lua.
			lazy = true,
			event = { "InsertEnter" },
			dependencies = {
				"L3MON4D3/LuaSnip",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-buffer",
				"saadparwaiz1/cmp_luasnip",
			},
		},
	},
	opts = {
		-- Automatically format on save
		autoformat = true,
		-- options for vim.lsp.buf.format
		-- `bufnr` and `filter` is handled by the LazyVim formatter,
		-- but can be also overridden when specified
		format = {
			formatting_options = nil,
			timeout_ms = nil,
		},
		-- LSP Server Settings
		servers = {
   --    ast_grep = {}, -- C, C++, RUST, GO, JAVA, PYTHON, C#, JAVASCRIPT, JSX, TYPESCRIPT, HTML, CSS, KOTLIN, DART, LUA
			-- bashls = {},
			-- cssls = {}, -- C, C++
			-- clangd = {}, -- C, C++
   --    deno = {},
			-- dockerls = {},
   --    emmet_ls = {},
			-- gopls = {},
   --    html = {},
   --    jsonls = {},
   --    ltex = {},
			-- -- ruff_lsp = {},
   --    sqlls = {},
			-- -- stylelint = {}, -- 
			-- taplo = {},
      -- unocss = {},
      -- ventur-vls = {}, -- VUE
			-- vimls = {},
			-- yamlls = {},
			-- yamls = {},
		},
		-- you can do any additional lsp server setup here
		-- return true if you don"t want this server to be setup with lspconfig
		setup = {
			-- example to setup with typescript.nvim
			-- tsserver = function(_, opts)
			--   require("typescript").setup({ server = opts })
			--   return true
			-- end,
			-- Specify * to use this function as a fallback for any server
			-- ["*"] = function(server, opts) end,
		},
	},
	config = function(_, opts)
		local servers = opts.servers
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		local function setup(server)
			local server_opts = vim.tbl_deep_extend("force", {
				capabilities = vim.deepcopy(capabilities),
			}, servers[server] or {})

			if opts.setup[server] then
				if opts.setup[server](server, server_opts) then
					return
				end
			elseif opts.setup["*"] then
				if opts.setup["*"](server, server_opts) then
					return
				end
			end
			require("lspconfig")[server].setup(server_opts)
		end

		-- temp fix for lspconfig rename
		-- https://github.com/neovim/nvim-lspconfig/pull/2439
		local mappings = require("mason-lspconfig.mappings.server")
		if not mappings.lspconfig_to_package.lua_ls then
			mappings.lspconfig_to_package.lua_ls = "lua-language-server"
			mappings.package_to_lspconfig["lua-language-server"] = "lua_ls"
		end

		local mlsp = require("mason-lspconfig")
		local available = mlsp.get_available_servers()

		local ensure_installed = {} ---@type string[]
		for server, server_opts in pairs(servers) do
			if server_opts then
				server_opts = server_opts == true and {} or server_opts
				-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
				if server_opts.mason == false or not vim.tbl_contains(available, server) then
					setup(server)
				else
					ensure_installed[#ensure_installed + 1] = server
				end
			end
		end

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = ensure_installed,
			automatic_installation = true,
		})
		require("mason-lspconfig").setup_handlers({ setup })
		require("lspconfig").lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
		-- require("lint").linters_by_ft = { 
  --     markdown = { "vale" },
  --   }
		require("lspconfig").pyright.setup({ capabilities = capabilities })
	end,
}
