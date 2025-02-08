local options = {
	base46 = {
    -- theme = "everblush",
    theme = "onedark",
		hl_override = {
			CursorLine = {
				bg = "#1e2227", -- Dark gray background
				underline = false, -- Add an underline
				italic = false, -- Make the text italic
			},
      CurSearch = { bg = "#607D8B" },
			Search = { bg = "#607D8B" },
			IncSearch = { bg = "#607D8B" },
		},
		transparency = true,
		theme_toggle = { "everblush", "one_light" },
	},
  lsp = { signature = true },
	ui = {
		cmp = { style = "atom", },-- default/flat_light/flat_dark/atom/atom_colored
		telescope = { style = "bordered" }, -- borderless / bordered
		statusline = {
			enabled = true,
			theme = "default",
			separator_style = "block",
			order = { "file", "git", "%=", "macro", "lsp_msg", "%=", "lsp", "diagnostics" },
			modules = {
				macro = function()
					local reg = vim.fn.reg_recording()
					if reg == "" then
						return " " -- not recording
					end
					return "rec @" .. reg .. " "
				end,
			},
		},
		tabufline = { enabled = false, },
	},
	cheatsheet = {
    theme = "simple",
		-- theme = "grid",
		excluded_groups = { "Default", ":help", "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
	},
  nvdash = { load_on_startup = false },
	colorify = { enabled = true, mode = "bg",
		highlight = { hex = true, lspvars = true },
	},
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
