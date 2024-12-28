local options = {
	base46 = {
		theme = "everblush",
		transparency = false,
		theme_toggle = { "everblush", "one_light" },
	},

	ui = {
		cmp = {
			icons_left = false, -- only for non-atom styles!
			lspkind_text = true,
			style = "default", -- default/flat_light/flat_dark/atom/atom_colored
			format_colors = {
				tailwind = false, -- will work for css lsp too
				icon = "󱓻",
			},
		},

		telescope = { style = "borderless" }, -- borderless / bordered

		statusline = {
			enabled = true,
			theme = "default",
			separator_style = "block",
			order = { "file", "git", "%=", "lsp_msg", "%=", "macro", "diagnostics", "lsp", "cwd" },
			modules = {
				macro = function()
					local reg = vim.fn.reg_recording()
					if reg == "" then
						return " "
					end -- not recording
					return "rec @" .. reg .. " "
				end,
				curs = function()
					local row, col = vim.api.nvim_win_get_cursor(0).unpack()
					local filename = vim.fn.expand("%:t")
					local total_lines = vim.api.nvim_buf_line_count(0)
					local percentage = math.floor((row / total_lines) * 100)
					return string.format("%s | Line %d/%d", filename, row, total_lines, percentage)
				end,
			},
		},

		-- lazyload it when there are 1+ buffers
		tabufline = {
			enabled = true,
			lazyload = true,
			order = { "treeOffset", "buffers", "tabs", "btns" },
			modules = nil,
		},
	},

	nvdash = { load_on_startup = false },

	term = {
		winopts = { number = false, relativenumber = false },
		sizes = { sp = 0.48, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
		float = {
			relative = "editor",
			row = 0.0,
			col = 0.0,
			width = 1.0,
			height = 0.8,
			border = "single",
		},
	},

	lsp = { signature = true },

	cheatsheet = {
		theme = "simple", -- simple/grid
		excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
	},

	mason = { pkgs = {}, skip = {} },

	colorify = {
		enabled = false,
		mode = "virtual", -- fg, bg, virtual
		virt_text = "󱓻 ",
		highlight = { hex = true, lspvars = true },
	},
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
