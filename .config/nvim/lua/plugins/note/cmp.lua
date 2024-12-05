return {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",--autocomplete on the buffer
            "hrsh7th/cmp-path",--autocomplete path variables
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",--autocomplete from luasnip
            "L3MON4D3/LuaSnip",
        },

        config = function()
            local luasnip = require("luasnip")
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ['&lt;CR&gt;'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({
                                    select = true,
                                })
                            end
                        else
                            fallback()
                        end
                    end),

                    ["&lt;Tab&gt;"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({select =true})
                            else
                                cmp.select_next_item()
                            end
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["&lt;S-Tab&gt;"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ['&lt;C-g&gt;'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                    ['&lt;C-f&gt;'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                    ['&lt;C-Space&gt;'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                    ['&lt;C-y&gt;'] = cmp.config.disable,
                    ['&lt;C-e&gt;'] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                },
                sources = cmp.config.sources({
                    { name = 'luasnip' },
                    { name = 'buffer'},
                }),
            })
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path', option = {trailing_slash = true}, }
                }, {
                        { name = 'cmdline' , option = {treat_trailing_slash =false}}
                    }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })
            cmp.setup.filetype("tex", {
                sources = {
                    { name = 'vimtex'},
                    { name = 'luasnip' },
                    { name = 'buffer'},
                },
            })
        end
    }
