return {
	"mrjones2014/smart-splits.nvim",
	keys = function()
		return {
			{ "<C-S-h>", require("smart-splits").resize_left, { desc = "resize_left" } },
			{ "<C-S-j>", require("smart-splits").resize_down, { desc = "resize_down" } },
			{ "<C-S-k>", require("smart-splits").resize_up, { desc = "resize_up" } },
			{ "<C-S-l>", require("smart-splits").resize_right, { desc = "resize_right" } },
			{ "<C-h>", require("smart-splits").move_cursor_left, { desc = "move_cursor_left" } },
			{ "<C-j>", require("smart-splits").move_cursor_down, { desc = "move_cursor_down" } },
			{ "<C-k>", require("smart-splits").move_cursor_up, { desc = "move_cursor_up" } },
			{ "<C-l>", require("smart-splits").move_cursor_right, { desc = "move_cursor_right" } },
			{ "<C-q>", ":bd<CR>", { desc = "buffer delete" } },
			-- { "<C-~>", require("smart-splits").move_cursor_previous, { desc = "move_cursor_previous" } },
			-- { "<leader><leader>h", require("smart-splits").swap_buf_left, { desc = "swap_buf_left" } },
			-- { "<leader><leader>j", require("smart-splits").swap_buf_down, { desc = "swap_buf_down" } },
			-- { "<leader><leader>k", require("smart-splits").swap_buf_up, { desc = "swap_buf_up" } },
			-- { "<leader><leader>l", require("smart-splits").swap_buf_right, { desc = "swap_buf_right" } },
		}
	end,
}
