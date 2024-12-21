return {
	"ibhagwan/fzf-lua",
	lazy = true,
	event = "UIEnter",
	keys = {

		{ mode = "n", "<leader>bb", "<cmd>FzfLua buffers<CR>", { desc = "find buffers" } },
		{
			mode = "n",
			"<leader>ff",
			function()
				require("fzf-lua").files({ cmd = "fd --type f --exclude node_modules" })
			end,
			{ desc = "find files" },
		},
		{ mode = "n", "<leader>fc", "<cmd>FzfLua colorschemes<cr>", { desc = "find files" } },
		{ mode = "n", "<leader>fac", "<cmd>FzfLua awesome_colorschemes<cr>", { desc = "find files" } },
		{ mode = "n", "<leader><C-o>", "<cmd>FzfLua jumps<cr>", { desc = "find jumplist" } },
		{ mode = "n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", { desc = "help page" } },
		{ mode = "n", "<leader>fk", "<cmd>FzfLua keymaps<cr>", { desc = "keymaps" } },
		{ mode = "n", "<leader>fo", "<cmd>FzfLua oldfiles<CR>", { desc = "find oldfiles" } },
		{ mode = "n", "<leader>fw", "<cmd>FzfLua live_grep_native<CR>", { desc = "live grep" } },

		{ mode = "n", "<leader>fq", "<cmd>FzfLua quickfix<cr>", { desc = "qf" } },
		{ mode = "n", "<leader>ql", "<cmd>FzfLua quickfix_stack<cr>", { desc = "qf stack" } },

		{ mode = "n", "<leader>frw", "<cmd>FzfLua live_grep_resume<CR>", { desc = "live grep resume" } },
		{ mode = "n", "<leader><leaderfw", "<cmd>FzfLua grep_last<CR>", { desc = "grep over last grep" } },

		{ mode = "n", "<leader>frr", "<cmd>FzfLua resume<CR>", { desc = "resume" } },
		{ mode = "n", "<A-r>", "<cmd>FzfLua resume<CR>", { desc = "resume" } },

		{ mode = "n", "<leader>gs", "<cmd>FzfLua git_status<CR>", { desc = "git status" } },
		{ mode = "n", "<leader>gc", "<cmd>FzfLua git_commits<CR>", { desc = "git commits" } },
		{ mode = "n", "<leader>gb", "<cmd>FzfLua git_bcommits<CR>", { desc = "git buffer-commits" } },
		-- {mode="n", "<leader>gb", "<cmd>FzfLua git_blame<CR>",        { desc = "git buffer-commits"}},
		{ mode = "n", "<leader>gr", "<cmd>FzfLua git_branches<CR>", { desc = "git buffer-commits" } },
		{ mode = "n", "<leader>gt", "<cmd>FzfLua git_tags<CR>", { desc = "git buffer-commits" } },
		{ mode = "n", "<leader>gs", "<cmd>FzfLua git_stash<CR>", { desc = "git buffer-commits" } },

		{ mode = "n", "<leader>ma", "<cmd>FzfLua marks<CR>", { desc = "find marks" } },

		-- { mode = "n", "<leader>ca", "<cmd>FzfLua col<CR>", { desc = "find marks"} },
	},
	opts = function()
		-- vim.cmd([[colorscheme github]])
		-- vim.cmd([[colorscheme everforest]])
		return {
			winopts = { split = "botright new" },
			oldfiles = { include_current_session = true },
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
					-- ["<A-r>"] = "<Esc>",
				},
			},
			previewers = {
				builtin = {
					extensions = {
						["png"] = { "viu", "-b" },
						["jpg"] = { "viu" },
					},
					-- ueberzug_scaler = "cover",
				},
			},
		}
	end,
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
