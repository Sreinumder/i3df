return {
	"hrsh7th/nvim-cmp", -- load luasnips + cmp related in insert mode only
	event = { "VeryLazy" },
	dependencies = {
		{ "saadparwaiz1/cmp_luasnip" }, -- cmp sources plugins
		{ "hrsh7th/cmp-nvim-lua" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-calc" },
		-- {"hrsh7th/cmp-path"},
		-- { "f3fora/cmp-spell" },
		{ "hrsh7th/cmp-cmdline" },
		"FelipeLema/cmp-async-path",
		"onsails/lspkind.nvim",
		{
			"L3MON4D3/LuaSnip", -- snippet plugin
			dependencies = "rafamadriz/friendly-snippets",
			opts = {
				history = true,
				updateevents = "TextChanged,TextChangedI",
			},
			config = function(_, opts)
				require("luasnip").config.set_config(opts)

				-- vscode format
				-- require("luasnip.loaders.from_vscode").lazy_load()
				require("luasnip.loaders.from_vscode").lazy_load({
					paths = vim.g.vscode_snippets_path or "",
          -- paths = "~/.config/nvim/snippets/snippet.json"
				})

				-- snipmate format
				require("luasnip.loaders.from_snipmate").load()
				require("luasnip.loaders.from_snipmate").lazy_load({
					paths = vim.g.snipmate_snippets_path or "",
				})

				-- lua format
				require("luasnip.loaders.from_lua").load()
				require("luasnip.loaders.from_lua").lazy_load({
					paths = vim.g.lua_snippets_path or "",
				})

				vim.api.nvim_create_autocmd("InsertLeave", {
					callback = function()
						if
							require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
							and not require("luasnip").session.jump_active
						then
							require("luasnip").unlink_current()
						end
					end,
				})
			end,
		},
	},
	opts = function()
		local cmp = require("cmp")
		local function border(hl_name)
			return {
				{ "╭", hl_name },
				{ "─", hl_name },
				{ "╮", hl_name },
				{ "│", hl_name },
				{ "╯", hl_name },
				{ "─", hl_name },
				{ "╰", hl_name },
				{ "│", hl_name },
			}
		end

		local options = {
			completion = {
				completeopt = "menu,menuone",
			},

			window = {
				completion = {
					winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
					scrollbar = false,
				},
				documentation = {
					border = border("CmpDocBorder"),
					winhighlight = "Normal:CmpDoc",
				},
			},

			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},

			mapping = {
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.close(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif require("luasnip").expand_or_jumpable() then
						vim.fn.feedkeys(
							vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
							""
						)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif require("luasnip").jumpable(-1) then
						vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
					else
						fallback()
					end
				end, { "i", "s" }),
			},
			sources = {
        { name = "luasnip" },
				{ name = "nvim_lsp" },
				{ name = "async_path"},
				-- { name = "path", },
				{ name = "nvim_lua" },
				{ name = "calc" },
				{
					name = "spell",
					option = {
						keep_all_entries = false,
						enable_in_context = function()
							return true
						end,
					},
				},
				{
					name = "buffer",
					option = {
						-- Avoid accidentally running on big files
						get_bufnrs = function()
							local buf = vim.api.nvim_get_current_buf()
							local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
							if byte_size > 1024 * 1024 then -- 1 Megabyte max
								return {}
							end
							return { buf }
						end,
					},
				},
			},
			formatting = {
				format = require("lspkind").cmp_format({
					mode = "symbol", -- show only symbol annotations
					maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
					-- can also be a function to dynamically calculate max width such as
					-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
					ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					show_labelDetails = true, -- show labelDetails in menu. Disabled by default

					-- The function below will be called before any actual modifications from lspkind
					-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
					-- before = function (entry, vim_item)
					--   return vim_item
					-- end
				}),
			},
		}

		return options
	end,
	config = function(_, opts)
		local cmp = require("cmp")
		require("cmp").setup(opts)
		require("cmp").setup.filetype("DressingInput", {
			sources = require("cmp").config.sources({ { name = "omni" } }),
		})
		require("cmp").setup.cmdline("/", {
			mapping = require("cmp").mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})
		require("cmp").setup.cmdline(":", { -- `:` cmdline setup.
			-- mapping = require("cmp").mapping.preset.cmdline(),
			sources = require("cmp").config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping(
					cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					{ "i", "c" }
				),
				["<C-p>"] = cmp.mapping(
					cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					{ "i", "c" }
				),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				-- ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				-- ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<Esc>"] = cmp.mapping(function(fallback)
					require("luasnip").unlink_current()
					fallback()
				end),
			}),
		})
	end,
}
