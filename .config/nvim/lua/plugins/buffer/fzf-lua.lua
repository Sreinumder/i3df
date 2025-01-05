return {
	"ibhagwan/fzf-lua",
	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	-- event = "UIEnter",
	keys = function()
		local function zoxide_query()
			local fzf = require("fzf-lua")
			local command = "zoxide query -l"
			local handle = io.popen(command)
			local result = handle:read("*a")
			handle:close()
			local paths = {}
			for path in result:gmatch("[^\r\n]+") do
				table.insert(paths, path)
			end
			-- Use fzf-lua to select from paths
			fzf.fzf_exec(paths, {
				prompt = "Zoxide> ",
				actions = {
					["default"] = function(selected)
						vim.cmd("cd " .. selected[1])
					end,
				},
			})
		end
		vim.api.nvim_create_user_command("Z", zoxide_query, {})
		local function get_treesitter_nodes()
			local bufnr = vim.api.nvim_get_current_buf()
			local language_tree = vim.treesitter.get_parser(bufnr)
			local syntax_tree = language_tree:parse()[1]
			local root = syntax_tree:root()

			local nodes = {}
			local line_counts = {}

			-- Walk through all nodes
			local function collect_nodes(tsnode, level)
				local node_type = tsnode:type()
				local start_row, start_col, end_row, end_col = tsnode:range()

				-- Skip nodes that span no lines
				if start_row == end_row and start_col == end_col then
					return
				end

				-- Get the text for this node
				local lines = vim.api.nvim_buf_get_lines(bufnr, start_row, end_row + 1, false)
				if #lines == 0 then
					return
				end

				local preview = lines[1]:gsub("^%s+", "")
				if #preview > 50 then
					preview = preview:sub(1, 47) .. "..."
				end

				local display = string.format(
					"%-20s │ %s:%d │ %s",
					node_type,
					vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t"),
					start_row + 1,
					preview
				)

				table.insert(nodes, {
					display = display,
					node_type = node_type,
					start_row = start_row,
					start_col = start_col,
					preview = preview,
				})

				-- Count nodes per line for better jumping
				line_counts[start_row] = (line_counts[start_row] or 0) + 1

				for child in tsnode:iter_children() do
					collect_nodes(child, level + 1)
				end
			end

			collect_nodes(root, 0)
			return nodes
		end

		local function jump_to_treesitter_node()
			local nodes = get_treesitter_nodes()
			if #nodes == 0 then
				vim.notify("No treesitter nodes found", vim.log.levels.WARN)
				return
			end

			local displays = vim.tbl_map(function(node)
				return node.display
			end, nodes)

			require("fzf-lua").fzf_exec(displays, {
				prompt = "TS Nodes> ",
				actions = {
					["default"] = function(selected)
						if not selected[1] then
							return
						end

						-- Find the corresponding node
						for _, node in ipairs(nodes) do
							if node.display == selected[1] then
								-- Jump to the node
								vim.api.nvim_win_set_cursor(0, { node.start_row + 1, node.start_col })

								-- Optional: highlight the node briefly
								vim.cmd("normal! zz")
								vim.fn.matchadd(
									"Search",
									string.format("\\%%%dl\\%%%dc", node.start_row + 1, node.start_col + 1)
								)
								vim.defer_fn(function()
									vim.cmd("call clearmatches()")
								end, 1000)
								break
							end
						end
					end,
				},
				winopts = {
					preview = {
						hidden = "hidden",
					},
				},
			})
		end
		vim.api.nvim_create_user_command("TSJump", jump_to_treesitter_node, {})
		local M = {
			{ mode = "n", "<leader>z", zoxide_query, { desc = "Zoxide directory jump" } },
			{ mode = "n", "<leader>tj", jump_to_treesitter_node, { desc = "Jump to Treesitter node" } },
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
			{
				mode = "n",
				"<leader>le",
				"<cmd>FzfLua lsp_workspace_diagnostics<CR>",
				{ desc = "diagnostics_workspace" },
			},
			{
				mode = { "n", "v", "i" },
				"<C-x><C-f>",
				function()
					require("fzf-lua").complete_path()
				end,
				{ silent = true, desc = "Fuzzy complete path" },
			},
		}
		return M
	end,
	opts = {
		-- winopts = { split = "botright new" }, -- this cause error
		winopts = { -- this is floating window setting
			row = 0.95, -- window row position (0=top, 1=bottom)
			col = 0.00, -- window col position (0=left, 1=right),
			height = 0.60, -- window height
			width = 1.00, -- window width
		},
		oldfiles = { include_current_session = true },
		previewers = {
			builtin = {
				extensions = {
					["png"] = { "viu", "-b" },
					["jpg"] = { "viu" },
				},
				-- ueberzug_scaler = "cover",
			},
		},
	},
}
