return {
	"mikavilpas/yazi.nvim",
  dependencies = "nvim-lua/plenary.nvim",
	keys = {
		{
			"<leader>ecw",
			"<cmd>Yazi cwd<cr>",
			desc = "Open yazi in nvim's pwd",
		},
		{
			"<A-e>",
			"<cmd>Yazi toggle<cr>",
			desc = "Resume the last yazi session",
		},
	},
	opts = {
		-- if you want to open yazi instead of netrw, see below for more info
		open_for_directories = false,
		keymaps = {
			show_help = "g?",
			open_file_in_vertical_split = "<c-v>",
			open_file_in_horizontal_split = "<c-s>",
			open_file_in_tab = "<c-t>",
			grep_in_directory = "<leader>fw",
			replace_in_directory = "<c-g>",
			-- cycle_open_buffers = "<tab>",
			copy_relative_path_to_selected_files = "<c-y>",
			send_to_quickfix_list = "<c-q>",
			change_working_directory = "Q",
		},
	},
}
