return {
	"lewis6991/gitsigns.nvim",
	event = "UIEnter",
	keys = {
		{
			"]c",
			function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					require("gitsigns").nav_hunk("next")
				end
			end,
			{ desc = "next hunk/change" },
		},
		{
			"[c",
			function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					require("gitsigns").nav_hunk("prev")
				end
			end,
			{ desc = "prev hunk/change" },
		},
		-- Actions
		{
			mode = { "v" },
			"<localleader>hs",
			function()
				require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end,
			{ desc = "stage_hunk" },
		},
		{
			mode = { "v" },
			"<localleader>hr",
			function()
				require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end,
			{ desc = "reset_hunk" },
		},
		{
			"<localleader>hB",
			function()
				require("gitsigns").blame_line({ full = true })
			end,
			{ desc = "blame_line" },
		},
		{
			"<localleader>hb",
			function()
				require("gitsigns").blame()
			end,
			{ desc = "blame_line" },
		},
		{
			"<localleader>hs",
			function()
				require("gitsigns").stage_hunk()
			end,
			{ desc = "stage_hunk" },
		},
		{
			"<localleader>hr",
			function()
				require("gitsigns").reset_hunk()
			end,
			{ desc = "reset_hunk" },
		},
		{
			"<localleader>hu",
			function()
				require("gitsigns").undo_stage_hunk()
			end,
			{ desc = "unstage hunk" },
		},
		{
			"<localleader>hp",
			function()
				require("gitsigns").preview_hunk()
			end,
			{ desc = "preview_hunk" },
		},
		{
			"<localleader>hS",
			function()
				require("gitsigns").stage_buffer()
			end,
			{ desc = "stage_buffer" },
		},
		{
			"<localleader>hR",
			function()
				require("gitsigns").reset_buffer()
			end,
			{ desc = "reset_buffer" },
		},
		{
			"<localleader>hR",
			function()
				require("gitsigns").undo_stage_buffer()
			end,
			{ desc = "reset_buffer" },
		},
		{
			",b",
			function()
				require("gitsigns").toggle_current_line_blame()
			end,
			{ desc = "toggle_line_blame" },
		},
		{
			"<localleader>hd",
			function()
				require("gitsigns").diffthis()
			end,
			{ desc = "gitsigns_diffthis" },
		},
		{
			"<localleader>td",
			function()
				require("gitsigns").toggle_deleted()
			end,
			{ desc = "toggle_deleted" },
		},
		{
			"<localleader>hD",
			function()
				require("gitsigns").diffthis("~")
			end,
			{ desc = "diffthis~" },
		},
		{ mode = { "o", "x" }, "ic", "<cmd>C-U>Gitsigns select_hunk<CR>", { desc = "hunk txtobj" } }, -- Text object
	},
	opts = function()
		local M = {
			count_chars = { "", "󰬻", "󰬼", "󰬽", "󰬾", "󰬿", "󰭀", "󰭁", "󰭂", ["+"] = "󰿮" },
			signs = {
				delete = { text = "󰍵" },
				changedelete = { text = "󱕖" },
			},
		}
		return M
	end,
}

-- return {
--   'echasnovski/mini.diff',
-- 	event = "UIEnter",
--   -- version = false,
-- }
