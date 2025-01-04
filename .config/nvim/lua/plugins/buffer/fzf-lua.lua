return {
	"ibhagwan/fzf-lua",
	lazy = true,
	event = "UIEnter",
	keys = {
		{ mode = "n", "<leader>f?", "<cmd>FzfLua builtin<CR>", { desc = "find fzflua-commands" } },
		-- find files faster
		{ mode = "n", "<leader>f<tab>", "<cmd>FzfLua buffers<CR>", { desc = "find buffers" } },
		{
			mode = "n",
			"<leader>ff",
			function()
				require("fzf-lua").files({ cmd = "fd --type f --exclude node_modules" })
			end,
			{ desc = "find files" },
		},

		-- { mode = "n", "<leader>fc", "<cmd>FzfLua colorschemes<cr>", { desc = "find files" } },
		-- { mode = "n", "<leader>fac", "<cmd>FzfLua awesome_colorschemes<cr>", { desc = "find files" } },
		{ mode = "n", "<leader>fo", "<cmd>FzfLua oldfiles<CR>", { desc = "buffer history" } },
		{ mode = "n", "<leader>fw", "<cmd>FzfLua live_grep_native<CR>", { desc = "live grep" } },
		-- { mode = "n", "<leader><leaderfw", "<cmd>FzfLua grep_last<CR>", { desc = "grep over last grep" } },
		-- { mode = "n", "<leader>frw", "<cmd>FzfLua live_grep_resume<CR>", { desc = "live grep resume" } },

		-- quick-fix and location list
		{ mode = "n", "<leader>fq", "<cmd>FzfLua quickfix<cr>", { desc = "qf" } },
		{ mode = "n", "<leader>ql", "<cmd>FzfLua quickfix_stack<cr>", { desc = "qf stack" } },
		{ mode = "n", "<leader><C-o>", "<cmd>FzfLua jumps<cr>", { desc = "find jumplist" } },
		{ mode = "n", "<leader>fa", "<cmd>FzfLua args<cr>", { desc = "args" } },

		-- { mode = "n", "<leader>frr", "<cmd>FzfLua resume<CR>", { desc = "resume" } },
		{ mode = "n", "<M-Esc>", "<cmd>FzfLua resume<CR>", { desc = "resume" } },

		--cword
		{ mode = "n", "<A-S-8>", "<cmd>FzfLua grep_cword<CR>", { desc = "cword rg" } },

		-- current-buffer specific
		{ mode = "n", "?", "<cmd>FzfLua lgrep_curbuf<CR>", { desc = "find buffers" } },
		{ mode = "n", "<leader>bl", "<cmd>FzfLua blines previewer=false<CR>", { desc = "find buffers" } },
		{ mode = "n", "<leader>bc", "<cmd>FzfLua git_bcommits<CR>", { desc = "buffer commits" } },
		{ mode = "n", "<leader>bt", "<cmd>FzfLua btags<CR>", { desc = "buffer tags" } },
		{ mode = "n", "<leader>bb", "<cmd>FzfLua git_blame<CR>", { desc = "git blame" } },

		-- misc
		{ mode = "n", "<leader>f:", "<cmd>FzfLua command_history<cr>", { desc = "command_history" } },
		{ mode = "n", "<leader>f/", "<cmd>FzfLua search_history<CR>", { desc = "search_history" } },
		{ mode = "n", "<leader>:", "<cmd>FzfLua command_history<cr>", { desc = "command_history" } },
		{ mode = "n", "<leader>/", "<cmd>FzfLua search_history<CR>", { desc = "search_history" } },
		{ mode = "n", "<leader>ft", "<cmd>FzfLua tags<cr>", { desc = "tags" } },
		{ mode = "n", "<leader>fk", "<cmd>FzfLua keymaps<cr>", { desc = "keymaps" } },
		{ mode = "n", "<leader>fm", "<cmd>FzfLua marks<CR>", { desc = "find marks" } },
		{ mode = "n", "<leader>fr", "<cmd>FzfLua register<CR>", { desc = "find register" } },
		{ mode = "n", "<leader>fM", "<cmd>FzfLua manpages<CR>", { desc = "man page" } },
		{ mode = "n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", { desc = "help page" } },
		{ mode = "n", "z=", "<cmd>FzfLua spell_suggest<CR>", { desc = "suggest_spell" } },
		{ mode = "n", ",ft", "<cmd>FzfLua filetypes<CR>", { desc = "set file_types" } },

		-- fzf git
		{ mode = "n", "<leader>gs", "<cmd>FzfLua git_status<CR>", { desc = "git status" } },
		{ mode = "n", "<leader>gc", "<cmd>FzfLua git_commits<CR>", { desc = "git commits" } },
		{ mode = "n", "<leader>gr", "<cmd>FzfLua git_branches<CR>", { desc = "git buffer-commits" } },
		{ mode = "n", "<leader>gt", "<cmd>FzfLua git_tags<CR>", { desc = "git buffer-commits" } },
		{ mode = "n", "<leader>gS", "<cmd>FzfLua git_stash<CR>", { desc = "git buffer-commits" } },
		{ mode = "n", "<leader>fc", "<cmd>FzfLua changes<cr>", { desc = "changes" } },

		--lsp
		{ mode = "n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<CR>", { desc = "Code Actions" } },
		{ mode = "n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<CR>", { desc = "Document Symbols" } },
		{ mode = "n", "<leader>lS", "<cmd>FzfLua lsp_workspace_symbols<CR>", { desc = "Workspace Symbols" } },
		{
			mode = "n",
			"<leader>LS",
			"<cmd>FzfLua lsp_live_workspace_symbols<CR>",
			{ desc = "Symbolslive Workspace  (query)" },
		},
		{ mode = "n", "<leader>lr", "<cmd>FzfLua lsp_references<CR>", { desc = "References" } },
		{ mode = "n", "<leader>lf", "<cmd>FzfLua lsp_finder<CR>", { desc = "All LSP locations" } },
		{ mode = "n", "<leader>ld", "<cmd>FzfLua lsp_definitions<CR>", { desc = "Definitions" } },
		{ mode = "n", "<leader>lD", "<cmd>FzfLua lsp_declarations<CR>", { desc = "Declarations" } },
		{ mode = "n", "<leader>lt", "<cmd>FzfLua lsp_typedefs<CR>", { desc = "Type Definitions" } },
		{ mode = "n", "<leader>li", "<cmd>FzfLua lsp_implementations<CR>", { desc = "Implementations" } },
		{ mode = "n", "<leader>lc", "<cmd>FzfLua lsp_incoming_calls<CR>", { desc = "Incoming Calls" } },
		{ mode = "n", "<leader>lC", "<cmd>FzfLua lsp_outgoing_calls<CR>", { desc = "Outgoing Calls" } },
		{ mode = "n", "<leader>le", "<cmd>FzfLua lsp_document_diagnostics<CR>", { desc = "diagnostics_document" } },
		{ mode = "n", "<leader>le", "<cmd>FzfLua lsp_workspace_diagnostics<CR>", { desc = "diagnostics_workspace" } },
	},
	opts = function()
		return {
			-- winopts = { split = "botright new" }, -- this cause error
			winopts = { -- this is floating window setting
				row = 0.95, -- window row position (0=top, 1=bottom)
				col = 0.00, -- window col position (0=left, 1=right),
				height = 0.60, -- window height
				width = 1.00, -- window width
			},
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
