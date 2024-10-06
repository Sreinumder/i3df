return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		{
			"s1n7ax/nvim-window-picker",
			name = "window-picker",
			version = "2.*",
			opts = {
				-- hint = 'statusline-winbar',
				hint = "floating-big-letter",
			},
		},
	},
 --  event = "BufEnter",
	-- cmd = "Neotree",
	keys = {
		{ "<leader>ee", ":Neotree toggle right<CR>", { desc = "NeoTree toggle" } },
		{ "<leader>eb", ":Neotree Buffer toggle right<CR>", { desc = "NeoTree buffer" } },
		{ "<leader>eg", ":Neotree git toggle right<CR>", { desc = "NeoTree git" } },
	},
	opts = {
		filesystem = {
      -- hijack_netrw_behavior = "open_default",
      hijack_netrw_behavior = "open_current",
			window = {
				position = "right",
				width = 30,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["h"] = "navigate_up",
					["l"] = "set_root",
					["L"] = "open",
					-- ["s"] = "split",
					["<A-l>"] = "focus_preview",
					["<A-j>"] = {
						"toggle_node",
						nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
					},
					["<esc>"] = "cancel", -- close preview or floating neo-tree window
					["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
					["S"] = "open_split",
					["<A-s>"] = "split_with_window_picker",
					["v"] = "open_vsplit",
					["<A-v>"] = "vsplit_with_window_picker",
					-- ["t"] = "open_tabnew",
					["L"] = "open_drop",
					-- ["t"] = "open_tab_drop",
					["w"] = "open_with_window_picker",
					--["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
					["C"] = "close_node",
					-- ['C'] = 'close_all_subnodes',
					["z"] = "close_all_nodes",
					--["Z"] = "expand_all_nodes",
					["a"] = {
						"add",
						-- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
						-- some commands may take optional config options, see `:h neo-tree-mappings` for details
						config = {
							show_path = "none", -- "none", "relative", "absolute"
						},
					},
					["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
					-- ["c"] = {
					--  "copy",
					--  config = {
					--    show_path = "none" -- "none", "relative", "absolute"
					--  }
					--}
					["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
					["<"] = "prev_source",
					[">"] = "next_source",
					["i"] = "show_file_details",
				},
			},
		},
	},
}
