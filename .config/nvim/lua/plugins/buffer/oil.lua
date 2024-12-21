return {
  'stevearc/oil.nvim',
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  event = "UIEnter",
  keys = {
    {"-", "<CMD>Oil<CR>", { desc = "Open parent directory" }},
    {"<A-->", "<CMD>Oil --float<CR>", { desc = "Open parent directory" }},
    -- {"-", "<CMD>Oil<CR>", { desc = "Open parent directory" }},
  },
  opts = {
    default_file_explorer = true,
    -- columns = { "icon", "permissions", "size", "mtime", },
    buf_options = { buflisted = false, bufhidden = "hide", },
    win_options = { wrap = false, signcolumn = "no", cursorcolumn = false, foldcolumn = "0",
      spell = false, list = false, conceallevel = 3, concealcursor = "nvic", },
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    prompt_save_on_select_new_entry = true,
    cleanup_delay_ms = 2000,
    lsp_file_methods = {
      enabled = true,
      timeout_ms = 1000,
      autosave_changes = false,
    },
    constrain_cursor = "editable",
    watch_for_changes = false,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      -- ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
      -- ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
      -- ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<A-->"] = "actions.close",
      ["<C-l>"] = "actions.refresh",
			["<C-s>"] = {
				function()
					require("oil").save()
					require("oil").close()
				end,
				desc = "Save & close",
			},
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory", mode = "n" },
      ["<leader>gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
    },
    use_default_keymaps = false,
    view_options = {
      show_hidden = true,
      is_hidden_file = function(name, bufnr)
        return vim.startswith(name, ".")
      end,
      is_always_hidden = function(name, bufnr)
        return false
      end,
      natural_order = true,
      case_insensitive = false,
      sort = { { "type", "asc" }, { "name", "asc" },
      },
    },
    extra_scp_args = {},
    git = {
      add = function(path)
        return false
      end,
      mv = function(src_path, dest_path)
        return false
      end,
      rm = function(path)
        return false
      end,
    },
		float = {
			border = vim.g.borderStyle,
			override = function(conf)
				local height = 0.85
				local width = 0.6
				conf.row = math.floor((1 - height) / 2 * vim.o.lines)
				conf.col = math.floor((1 - width) / 2 * vim.o.columns)
				conf.height = math.floor(vim.o.lines * height)
				conf.width = math.floor(vim.o.columns * width)
				return conf
			end,
			preview_split = "below",

			-- FIX display relative path of directory, not absolute one
			get_win_title = function(winid)
				local bufnr = vim.api.nvim_win_get_buf(winid)
				local absPath = vim.api.nvim_buf_get_name(bufnr):gsub("^oil://", "")
				local cwd = vim.uv.cwd() or ""
				local relPath = "." .. absPath:sub(#cwd + 1)
				local title = vim.startswith(absPath, cwd) and relPath or absPath:gsub(vim.env.HOME, "~")
				return " " .. title .. " "
			end,
		},
    preview = {
      min_width = { 40, 0.4 },
      width = nil,
      max_height = 0.9,
      min_height = { 5, 0.1 },
      height = nil,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
      update_on_cursor_moved = true,
    },
    ssh = { border = "rounded", },
    keymaps_help = { border = "rounded", },
  },
}
-- return {
-- 	"stevearc/oil.nvim",
-- 	dependencies = "echasnovski/mini.icons",
--
-- 	keys = {
-- 		{ "-", "<cmd>Oil --float<CR>", desc = "󰁴 Oil" },
-- 	},
--
-- 	---@module "oil"
-- 	---@type oil.SetupOpts
-- 	opts = {
-- 		delete_to_trash = true,
-- 		skip_confirm_for_simple_edits = false,
-- 		use_default_keymaps = false,
-- 		keymaps = {
-- 			["?"] = { "actions.show_help", mode = "n" },
-- 			["q"] = { "actions.close", mode = "n", nowait = true },
-- 			["gs"] = { "actions.change_sort", mode = "n" },
-- 			["C"] = { "actions.cd", mode = "n" },
-- 			["<CR>"] = "actions.select",
-- 			["<Tab>"] = { "actions.parent" },
-- 			["<C-r>"] = { "actions.refresh" },
-- 			["<C-p>"] = { "actions.preview" },
-- 			["<C-s>"] = {
-- 				function()
-- 					require("oil").save()
-- 					require("oil").close()
-- 				end,
-- 				desc = "Save & close",
-- 			},
-- 		},
-- 		columns = { "icon" }, -- mtime,size
-- 		win_options = {
-- 			statuscolumn = " ", -- adds paddings
-- 		},
-- 		confirmation = {
-- 			border = vim.g.borderStyle,
-- 		},
-- 		float = {
-- 			border = vim.g.borderStyle,
-- 			override = function(conf)
-- 				local height = 0.85
-- 				local width = 0.6
-- 				conf.row = math.floor((1 - height) / 2 * vim.o.lines)
-- 				conf.col = math.floor((1 - width) / 2 * vim.o.columns)
-- 				conf.height = math.floor(vim.o.lines * height)
-- 				conf.width = math.floor(vim.o.columns * width)
-- 				return conf
-- 			end,
-- 			preview_split = "below",
--
-- 			-- FIX display relative path of directory, not absolute one
-- 			get_win_title = function(winid)
-- 				local bufnr = vim.api.nvim_win_get_buf(winid)
-- 				local absPath = vim.api.nvim_buf_get_name(bufnr):gsub("^oil://", "")
-- 				local cwd = vim.uv.cwd() or ""
-- 				local relPath = "." .. absPath:sub(#cwd + 1)
-- 				local title = vim.startswith(absPath, cwd) and relPath or absPath:gsub(vim.env.HOME, "~")
-- 				return " " .. title .. " "
-- 			end,
-- 		},
-- 	},
-- }
