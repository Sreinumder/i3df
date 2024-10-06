return {
	"AckslD/muren.nvim",
	config = true,
	keys = {
		{ "<leader>rr", ":MurenToggle<CR>", { desc = "muren toggle" } },
		{ "<localleader>rf", ":MurenFresh<CR>", { desc = "muren toggle" } },
	},
	opts = {
		create_commands = true,
		filetype_in_preview = true,
		-- default togglable options
		two_step = false,
		all_on_line = true,
		preview = true,
		cwd = false,
		files = "**/*",
		-- keymaps
		keys = {
			close = "q",
			toggle_side = "<Tab>",
			toggle_options_focus = "<C-s>",
			toggle_option_under_cursor = "<CR>",
			scroll_preview_up = "<A-k>",
			scroll_preview_down = "<A-j>",
			do_replace = "<CR>",
			-- NOTE these are not guaranteed to work, what they do is just apply `:normal! u` vs :normal! <C-r>`
			-- on the last affected buffers so if you do some edit in these buffers in the meantime it won't do the correct thing
			do_undo = "<A-u>",
			do_redo = "<A-r>",
		},
		-- ui sizes
		patterns_width = 30,
		patterns_height = 10,
		options_width = 20,
		preview_height = 12,
		-- window positions
		anchor = "center", -- Set to one of:
		-- 'center' | 'top' | 'bottom' | 'left' | 'right' | 'top_left' | 'top_right' | 'bottom_left' | 'bottom_right'
		vertical_offset = 0, -- offsets are relative to anchors
		horizontal_offset = 0,
		-- options order in ui
		order = {
			"buffer",
			"dir",
			"files",
			"two_step",
			"all_on_line",
			"preview",
		},
		-- highlights used for options ui
		hl = {
			options = {
				on = "@string",
				off = "@variable.builtin",
			},
			preview = {
				cwd = {
					path = "Comment",
					lnum = "Number",
				},
			},
		},
	},
}
