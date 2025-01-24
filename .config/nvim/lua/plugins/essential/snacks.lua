return {
	"folke/snacks.nvim",
	enabled = false,
	dependencies = {
		"HiPhish/rainbow-delimiters.nvim",
	},
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		indent = {
			indent = { enabled = true }, -- indent guides
			animate = {
				enabled = vim.fn.has("nvim-0.10") == 1,
				style = "out",
				easing = "linear",
				duration = {
					step = 20, -- ms per step
					total = 500, -- maximum duration
				},
			},
			scope = {
				enabled = true, -- enable highlighting the current scope
				char = "│",
				underline = false, -- underline the start of the scope
				only_current = false, -- only show scope in the current window
				hl = {
					"RainbowDelimiterGreen",
					"RainbowDelimiterOrange",
					"RainbowDelimiterBlue",
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			},
			-- filter for buffers to enable indent guides
			filter = function(buf)
				return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
			end,
		},
		input = { enabled = true },
		notifier = {
			enabled = true,
			{
				timeout = 3000, -- default timeout in ms
				width = { min = 40, max = 0.4 },
				height = { min = 1, max = 0.6 },
				-- editor margin to keep free. tabline and statusline are taken into account automatically
				margin = { top = 0, right = 1, bottom = 0 },
				padding = true, -- add 1 cell of left/right padding to the notification window
				sort = { "level", "added" }, -- sort by level and time
				-- minimum log level to display. TRACE is the lowest
				-- all notifications are stored in history
				level = vim.log.levels.TRACE,
				icons = {
					error = " ",
					warn = " ",
					info = " ",
					debug = " ",
					trace = " ",
				},
				keep = function(notif)
					return vim.fn.getcmdpos() > 0
				end,
				style = "round",
				top_down = true, -- place notifications from top to bottom
				date_format = "%R", -- time format for notifications
				more_format = " ↓ %d lines ",
				refresh = 50, -- refresh at most every 50ms
			},
		},
		quickfile = { enabled = true },
		scroll = { enabled = false },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		lazygit = { enabled = true },
	},
}
