return {
	"kevinhwang91/nvim-hlslens",
	keys = {
		{
			"n",
			[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
			{ noremap = true, silent = true },
		},
		{
			"N",
			[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
			{ noremap = true, silent = true },
		},
		{ "*", [[*<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true } },
		{ "#", [[#<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true } },
		{ "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true } },
		{ "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true } },
		{ "<Leader>,l", "<Cmd>HlSearchLensToggle<CR>", { noremap = true, silent = true } },
	},
	event = { "UIEnter" },
}
