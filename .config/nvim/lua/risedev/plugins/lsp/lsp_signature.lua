return {
	"ray-x/lsp_signature.nvim",
	event = { "InsertEnter" },
	opts = {
		floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
		floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
		hint_scheme = "Comment", -- highlight group for the virtual text
	},
}
