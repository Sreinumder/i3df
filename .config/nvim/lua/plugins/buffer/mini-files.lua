return {
	"echasnovski/mini.files",
	lazy = true,
	keys = {
		{
			"<leader><leader>",
			function()
				if not require("mini.files").close() then
					require("mini.files").open()
				end
			end,
			{ desc = "mini.file" },
		},
		{
			"-",
			function()
				local buffer_path = vim.api.nvim_buf_get_name(0)
				local parent_directory = vim.fn.fnamemodify(buffer_path, ":h")
				print(parent_directory)
				require("mini.files").open(parent_directory)
			end,
			{ desc = "mini.file" },
		},
	},
	opts = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesWindowUpdate",
			callback = function(args)
				local buf_id = args.data.buf_id
				vim.api.nvim_buf_set_keymap(buf_id, "n", "<A-j>", "j", {})
				vim.api.nvim_buf_set_keymap(buf_id, "n", "<A-k>", "k", {})
				vim.wo[args.data.win_id].relativenumber = true
				vim.wo[args.data.win_id].number = true
			end,
		})
		vim.api.nvim_create_autocmd('User', {
			pattern = 'MiniFilesWindowOpen',
			callback = function(args)
				local win_id = args.data.win_id
				local config = vim.api.nvim_win_get_config(win_id)
				config.border, config.title_pos = 'single', 'center'
				vim.api.nvim_win_set_config(win_id, config)
			end,
		})
		return {
			content = { prefix = function() end },
			mappings = {
				close = "<ESC>",
				-- go_in       = '<A-l>',
				go_in = "<A-l>",
				go_in_plus = "<CR>",
				-- go_out      = '<A-h>',
				go_out = "-",
				go_out_plus = "<A-h>",
				mark_goto = "'",
				mark_set = "m",
				reset = "<BS>",
				reveal_cwd = "@",
				show_help = "g?",
				synchronize = "=",
				trim_left = "<",
				trim_right = ">",
			},

			-- General options
			options = {
				permanent_delete = false,
				use_as_default_explorer = true,
			},

			-- Customization of explorer windows
			windows = {
				max_number = math.huge,
				preview = true,
				width_focus = 50,
				width_nofocus = 15,
				width_preview = 70,
			},
		}
	end,
}
