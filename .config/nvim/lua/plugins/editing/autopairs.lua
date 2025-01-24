-- ┌───────────────────────────────────┐
-- │automatically finds and sets pairs │
-- └───────────────────────────────────┘
return {
	"windwp/nvim-autopairs",
	-- event = { "InsertEnter" },
	dependencies = {
		-- "hrsh7th/nvim-cmp",
	},
	opts = {
		check_ts = true, -- enable treesitter
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" },
    ts_config = {
      lua = { "string" }, -- don't add pairs in lua string treesitter nodes
      javascript = { "template_string" }, -- don't add pairs in javscript
      java = false, -- don't check treesitter on java
    },
  },
  event = "UIEnter",
}

--     {
--       "windwp/nvim-autopairs",
--       opts = {
--         fast_wrap = {},
--         disable_filetype = { "TelescopePrompt", "vim" },
--       },
--       config = function(_, opts)
--         require("nvim-autopairs").setup(opts)
--
--         -- setup cmp for autopairs
--         local cmp_autopairs = require "nvim-autopairs.completion.cmp"
--         require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
--       end,
--     },
