return {
	"yujinyuz/gitpad.nvim",
	opts = {
		title = "gitpad",
		dir = "~/notes/gitpad",
		window_type = "split",
		split_win_opts = {
			split = "right",
		},
	},
	keys = {
		{
			"<localleader>np",
			function()
				require("gitpad").toggle_gitpad() -- or require('gitpad').toggle_gitpad({ title = 'Project notes' })
			end,
			desc = "gitpad project",
		},
		{
			"<localleader>nb",
			function()
				require("gitpad").toggle_gitpad_branch() -- or require('gitpad').toggle_gitpad_branch({ title = 'Branch notes' })
			end,
			desc = "gitpad branch",
		},
		-- Daily notes
		{
			"<localleader>nd",
			function()
				local date_filename = "daily-" .. os.date("%Y-%m-%d.md")
				require("gitpad").toggle_gitpad({ filename = date_filename }) -- or require('gitpad').toggle_gitpad({ filename = date_filename, title = 'Daily notes' })
			end,
			desc = "gitpad daily notes",
		},
		-- Per file notes
		{
			"<localleader>nf",
			function()
				local filename = vim.fn.expand("%:p") -- or just use vim.fn.bufname()
				if filename == "" then
					vim.notify("empty bufname")
					return
				end
				filename = vim.fn.pathshorten(filename, 2) .. ".md"
				require("gitpad").toggle_gitpad({ filename = filename }) -- or require('gitpad').toggle_gitpad({ filename = filename, title = 'Current file notes' })
			end,
			desc = "gitpad per file notes",
		},
	},
}
