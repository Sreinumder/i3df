return {
	"echasnovski/mini.surround",
	version = "*",
  keys = {
    { "gs", mode={ "n", "x" } },
    { "ds", mode={ "n", "x" } },
    { "ms", mode={ "n", "x" } },
    { "cs", mode={ "n", "x" } },
  },
	opts = {
		-- Add custom surroundings to be used on top of builtin ones. For more
		-- information with examples, see `:h MiniSurround.config`.
		custom_surroundings = nil,

		-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
		highlight_duration = vim.g.change_hl_duration,

		-- Module mappings. Use `''` (empty string) to disable one.
		mappings = {
			add = "gs", -- Add surrounding in Normal and Visual modes
			delete = "ds", -- Delete surrounding
      replace = "cs", -- Change surrounding
			find = "msn", -- Find surrounding next
			find_left = "msl", -- Find surrounding last
			highlight = "msh", -- Highlight surrounding
			-- update_n_lines = "ysu", -- Update `n_lines`
			suffix_last = "l", -- Suffix to search with "prev" method
			suffix_next = "n", -- Suffix to search with "next" method
		},
		n_lines = 50, -- Number of lines within which surrounding is searched
		respect_selection_type = true,
		search_method = "cover",
		silent = false, -- Whether to disable showing non-error feedback
	},
}
