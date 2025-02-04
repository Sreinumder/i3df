return {
	"echasnovski/mini.diff",
  -- event = "InsertEnter",
	event = "UIEnter",
  lazy = true,
  -- keys = {
  --   {"<leader>,md", function() require("mini.diff").toggle(vim.api.nvim_get_current_buf()) end, {desc = "toggle minidiff"}}
  -- },
	opts = {
		view = {
      -- style = "sign",
      style = "number",
			signs = { add = "│", change = "┃", delete = "-" },

			-- Priority of used visualization extmarks
			priority = 199,
		},

		-- Source for how reference text is computed/updated/etc
		-- Uses content from Git index by default
		source = nil,

		-- Delays (in ms) defining asynchronous processes
		delay = {
			-- How much to wait before update following every text change
			text_change = 200,
		},

		-- Module mappings. Use `''` (empty string) to disable one.
		mappings = {
			apply = ";a", -- Apply hunks inside a visual/operator region
			reset = ";r", -- Reset hunks inside a visual/operator region
			textobject = "ic",
			goto_first = "[C",
			goto_prev = "[c",
			goto_next = "]c",
			goto_last = "]C",
		},

		-- Various options
		options = {
			-- Diff algorithm. See `:h vim.diff()`.
			algorithm = "histogram",

			-- Whether to use "indent heuristic". See `:h vim.diff()`.
			indent_heuristic = true,

			-- The amount of second-stage diff to align lines (in Neovim>=0.9)
			linematch = 60,

			-- Whether to wrap around edges during hunk navigation
			wrap_goto = false,
		},
	},
}
