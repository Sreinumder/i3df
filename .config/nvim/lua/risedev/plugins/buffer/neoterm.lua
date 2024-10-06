return {
	"itmecho/neoterm.nvim",
	keys = {
		{ "<A-t><A-t>",     "<cmd>NeotermToggle<CR>", { desc = "NeoTermToggle" }, mode = { "n", "c", "t" }},
		{ "<A-t><A-r><A-r>",     ":NeotermRun<space>", { desc = "NeoTermToggle" }, mode = { "n", "c", "t" }},
		{ "<A-t><A-r><A-l>",":NeotermRun<space>lazygit<CR>", { desc = "NeoTermToggle" }, mode = { "n", "c", "t" }},
		{ "<A-t><A-t><A-r>","<cmd>NeotermRerun<CR>", { desc = "NeoTermToggle" }, mode = { "n", "c", "t" }},
		{ "<A-t><A-q>",     "<cmd>NeotermExit<CR>", { desc = "NeoTermToggle" }, mode = { "n", "c", "t" }},
	},
	opts = {
		clear_on_run = true, -- run clear command before user specified commands
		mode = "horizontal", -- vertical/horizontal/fullscreen
		noinsert = false, -- disable entering insert mode when opening the neoterm window
	},
}
