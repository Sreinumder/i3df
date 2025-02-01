return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = function()
		local Path = require("plenary.path")

		-- Function to toggle enabled state in plugin file
		-- local function toggle_plugin_state(file_path)
		--   local content = Path:new(file_path):read()
		--
		--   -- Look for enabled = true/false pattern
		--   local new_content
		--   if content:match('enabled%s*=%s*false') then
		--     new_content = content:gsub('enabled%s*=%s*false', 'enabled = true')
		--     -- Load the plugin using Lazy
		--     require('lazy').load({ plugins = { Path:new(file_path):stem() } })
		--   elseif content:match('enabled%s*=%s*true') then
		--     new_content = content:gsub('enabled%s*=%s*true', 'enabled = false')
		--     -- Unload plugin if possible
		--     local plugin_name = Path:new(file_path):stem()
		--     if require('lazy.core.config').plugins[plugin_name] then
		--       require('lazy.core.loader').disable(plugin_name)
		--     end
		--   else
		--     print("No enabled state found in file")
		--     return
		--   end
		--
		--   -- Write changes back to file
		--   Path:new(file_path):write(new_content, 'w')
		-- end

		local function zoxide_query()
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
				preview = "eza --icons --color=auto -alh {}",
			})
		end
		vim.api.nvim_create_user_command("Z", zoxide_query, {})

		local function get_treesitter_nodes(query_s)
			local bufnr = vim.api.nvim_get_current_buf()
			local bufname = vim.api.nvim_buf_get_name(bufnr)
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

				local display = string.format("%-23s │ %d: %s", node_type, start_row + 1, preview)

				if query_s == nil or node_type == query_s then
					table.insert(nodes, {
						display = display,
						node_type = node_type,
						start_row = start_row,
						start_col = start_col,
						end_row = end_row,
						end_col = end_col,
						preview = preview,
						bufname = bufname,
					})
				end

				-- Count nodes per line for better jumping
				line_counts[start_row] = (line_counts[start_row] or 0) + 1

				for child in tsnode:iter_children() do
					collect_nodes(child, level + 1)
				end
			end

			collect_nodes(root, 0)
			return nodes
		end

		local function jump_to_treesitter_node(query_s)
			local nodes = get_treesitter_nodes(query_s)
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
				-- preview = {
				-- 	type = "cmd",
				-- 	fn = function(selected)
				-- 		for _, node in ipairs(nodes) do
				-- 			if node.display == selected[1] then
				-- 				cmd = "bat --line-range "
				-- 					.. node.start_row
				-- 					-- .. ":"
				-- 					-- .. node.start_col
				-- 					-- .. ":"
				-- 					-- .. node.end_row
				-- 					-- .. ":"
				-- 					-- .. node.end_col
				-- 					.. " "
				-- 					.. node.bufname
				-- 				print(cmd)
				-- 				return cmd
				-- 			end
				-- 		end
				-- 	end,
				-- },
			})
		end
		vim.api.nvim_create_user_command("TSJump", jump_to_treesitter_node, {})
		local M = {
			{ mode = "n", "<leader>fd", zoxide_query, { desc = "Zoxide directory jump" } },
			{ mode = "n", "<leader>fT", jump_to_treesitter_node, { desc = "Jump to Treesitter node" } },
			{ mode = "n", "<leader>f?", "<cmd>FzfLua builtin<CR>", { desc = "find fzflua-commands" } },
			{ mode = "n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "find buffers" } },
			{
				mode = "n",
				"<leader>ff",
				function()
					require("fzf-lua").files({ cmd = "fd --type f --exclude node_modules" })
				end,
				{ desc = "find files" },
			},

			{ mode = "n", "<leader>fo", "<cmd>FzfLua oldfiles<CR>", { desc = "buffer history" } },
			{ mode = "n", "<leader>fw", "<cmd>FzfLua live_grep_native<CR>", { desc = "live grep" } },
			{
				mode = "n",
				"<leader>fn",
				function()
					require("fzf-lua").live_grep_native({ prompt = "Notes> ", cwd = "~/notes/" })
				end,
			},
			{
				mode = "n",
				"<leader>fp",
				function()
					require("fzf-lua").live_grep_native({ prompt = "plugins> ", cwd = "~/.config/nvim/" })
				end,
			},
			-- { mode = "n", "<leader><leaderfw", "<cmd>FzfLua grep_last<CR>", { desc = "grep over last grep" } },
			-- { mode = "n", "<leader>frw", "<cmd>FzfLua live_grep_resume<CR>", { desc = "live grep resume" } },

			-- quick-fix and location list
			{ mode = "n", "<leader>fq", "<cmd>FzfLua quickfix<cr>", { desc = "qf" } },
			{ mode = "n", "<leader>fQ", "<cmd>FzfLua quickfix_stack<cr>", { desc = "qf stack" } },
			{ mode = "n", "<leader>fa", "<cmd>FzfLua args<cr>", { desc = "args" } },

			-- { mode = "n", "<leader>frr", "<cmd>FzfLua resume<CR>", { desc = "resume" } },
			{ mode = "n", "<M-Esc>", "<cmd>FzfLua resume<CR>", { desc = "resume" } },

			--cword
			{ mode = "n", "<A-S-8>", "<cmd>FzfLua grep_cword<CR>", { desc = "cword rg" } },

			-- misc
			{ mode = "n", "<leader>fl", "<cmd>FzfLua lgrep_curbuf<CR>", { desc = "find buffers" } },
			{ mode = "n", "<leader><C-o>", "<cmd>FzfLua jumps<cr>", { desc = "find jumplist" } },
			{ mode = "n", "<leader>f<C-o>", "<cmd>FzfLua jumps<cr>", { desc = "find jumplist" } },
			{ mode = "n", "<leader>f:", "<cmd>FzfLua command_history<cr>", { desc = "command_history" } },
			{ mode = "n", "<leader>f/", "<cmd>FzfLua search_history<CR>", { desc = "search_history" } },
			{ mode = "n", "<leader>:", "<cmd>FzfLua command_history<cr>", { desc = "command_history" } },
			{ mode = "n", "<leader>/", "<cmd>FzfLua search_history<CR>", { desc = "search_history" } },
			{ mode = "n", "<leader>ft", "<cmd>FzfLua treesitter<cr>", { desc = "treesitter" } },
			{ mode = "n", "<leader>fk", "<cmd>FzfLua keymaps<cr>", { desc = "keymaps" } },
			{ mode = "n", "<leader>fm", "<cmd>FzfLua marks<CR>", { desc = "find marks" } },
			{ mode = "n", "<leader>fr", "<cmd>FzfLua registers<CR>", { desc = "find registers" } },
			{ mode = "n", "<leader>fM", "<cmd>FzfLua manpages<CR>", { desc = "man page" } },
			{ mode = "n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", { desc = "help page" } },
			{ mode = "n", "<leader>,ft", "<cmd>FzfLua filetypes<CR>", { desc = "set file_types" } },

			{ mode = "n", "<leader>z=", "<cmd>FzfLua spell_suggest<CR>", { desc = "suggest_spell" } },
			-- fzf git
			{ mode = "n", "<leader>bb", "<cmd>FzfLua git_blame<CR>", { desc = "git blame" } },
      { mode = "n", "<leader>gf", "<cmd>FzfLua git_files<CR>", { desc = "git files" } },
      { mode = "n", "<leader>fc", "<cmd>FzfLua git_bcommits<CR>", { desc = "buffer commits" } },
			{ mode = "n", "<leader>fC", "<cmd>FzfLua git_commits<CR>", { desc = "git commits" } },
			{ mode = "n", "<leader>gs", "<cmd>FzfLua git_status<CR>", { desc = "git status" } },
			{ mode = "n", "<leader>gc", "<cmd>FzfLua git_commits<CR>", { desc = "git commits" } },
			{ mode = "n", "<leader>gb", "<cmd>FzfLua git_branches<CR>", { desc = "git buffer-commits" } },
			{ mode = "n", "<leader>gt", "<cmd>FzfLua git_tags<CR>", { desc = "git tags" } },
			{ mode = "n", "<leader>gS", "<cmd>FzfLua git_stash<CR>", { desc = "git buffer-commits" } },

			--lsp
			{ mode = "n", "<leader>la", "<cmd>FzfLua lsp_code_actions<CR>", { desc = "Code Actions" } },
			{ mode = "n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<CR>", { desc = "Document Symbols" } },
			{ mode = "n", "<leader>lS", "<cmd>FzfLua lsp_workspace_symbols<CR>", { desc = "Workspace Symbols" } },
			{
				mode = "n",
				"<leader>lS",
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
				"<leader>lx",
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
	opts = function()
    return {
				winopts = { -- this is floating window setting
					row = 0.95, -- window row position (0=top, 1=bottom)
					col = 0.00, -- window col position (0=left, 1=right)
					height = 0.60, -- window height
					width = 1.00, -- window width
				},
				oldfiles = { include_current_session = true },
				keymap = {
					fzf = {
						["ctrl-q"] = "select-all+accept",
						["ctrl-d"] = "preview-page-down",
						["ctrl-u"] = "preview-page-up",
						["alt-a"] = "toggle-all",
					},
				},
				git = {
					files = {
						prompt = "GitFiles❯ ",
						cmd = "git ls-files --exclude-standard",
						multiprocess = true, -- run command in a separate process
						git_icons = true, -- show git icons?
						file_icons = true, -- show file icons (true|"devicons"|"mini")?
						color_icons = true, -- colorize file|git icons
						-- force display the cwd header line regardless of your current working
						-- directory can also be used to hide the header when not wanted
						-- cwd_header = true
					},
					status = {
						prompt = "GitStatus❯ ",
						cmd = "git -c color.status=false --no-optional-locks status --porcelain=v1 -u",
						multiprocess = true, -- run command in a separate process
						file_icons = true,
						color_icons = true,
						previewer = "git_diff",
						-- preview_pager = false,
						actions = {
						  ["right"]   = false,
						  ["left"]    = false,
							["alt-s"] = { fn = require("fzf-lua").actions.git_stage_unstage, reload = true },
							["alt-x"] = { fn = require("fzf-lua").actions.git_reset, reload = true },
						},
					},
				},
				previewers = {
					builtin = {
						extensions = {
							["png"] = { "viu", "-b" },
							["jpg"] = { "viu" },
						},
					},
				},
      }
    end,
}
