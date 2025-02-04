return {
	'saghen/blink.cmp',
	version = '*',
	-- event = "VeryLazy",
	dependencies = {},
	opts = {
		keymap = { preset = 'super-tab' }, -- enter default
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer',
        -- "avante_commands",
        -- "avante_mentions",
        -- "avante_files",
    },
			providers = {
				lsp = {
            name = "[lsp]",
          },
			},
		}
	}
}
