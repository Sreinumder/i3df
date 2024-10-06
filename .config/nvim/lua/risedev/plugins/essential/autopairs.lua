-- ┌───────────────────────────────────┐
-- │automatically finds and sets pairs │
-- └───────────────────────────────────┘
return {
	"windwp/nvim-autopairs",
	-- event = { "InsertEnter" },
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
	opts = {
		check_ts = true, -- enable treesitter
		ts_config = {
			lua = { "string" }, -- don't add pairs in lua string treesitter nodes
			javascript = { "template_string" }, -- don't add pairs in javscript
			java = false, -- don't check treesitter on java
		},
	},
}
