return {
	'saghen/blink.cmp',
	version = '*',
	event = "VeryLazy",
	dependencies = {},
	opts = {
    keymap = { preset = 'super-tab' }, -- enter default
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer', },
			providers = {
				lsp = {
            name = "[lsp]",
          },
			},
		}
	}
}
