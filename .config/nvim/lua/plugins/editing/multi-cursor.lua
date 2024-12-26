-- it is well working
-- it is well working
-- it is well working
return {
	"jake-stewart/multicursor.nvim",
	keys = function()
		local mc = require("multicursor-nvim")
		local M = {
			{
				mode = { "n", "v" },
				"<C-A-k>",
				function()
					mc.lineAddCursor(-1)
				end,
			},
			{
				mode = { "n", "v" },
				"<C-A-j>",
				function()
					mc.lineAddCursor(1)
				end,
			},
			{
				mode = { "n", "v" },
				"<C-A-S-K>",
				function()
					mc.lineSkipCursor(-1)
				end,
			},
			{
				mode = { "n", "v" },
				"<C-A-S-J>",
				function()
					mc.lineSkipCursor(1)
				end,
			},
			{
				mode = { "n", "v" },
				"<C-A-p>",
				function()
					mc.matchAddCursor(-1)
				end,
			}, -- Add or skip adding a new cursor by matching word/selection
			{
				mode = { "n", "v" },
				"<C-A-p>",
				function()
					mc.matchSkipCursor(-1)
				end,
			},
			{
				mode = { "n", "v" },
				"<C-A-8>",
				function()
					mc.matchAddCursor(1)
				end,
			},
			{
				mode = { "n", "v" },
				"<C-A-S-8>",
				function()
					mc.matchSkipCursor(1)
				end,
			},

			{ mode = { "n", "v" }, "<C-A-/>", mc.matchAllAddCursors }, -- Add all matches in the document

			-- You can also add cursors with any motion you prefer:
			-- {mode="n", "<right>", function() mc.addCursor("w") end},
			{
				mode = "n",
				"<leader><right>",
				function()
					mc.skipCursor("w")
				end,
			},

			-- Rotate the main cursor.
			{ mode = { "n", "v" }, "<C-A-h>", mc.prevCursor },
			{ mode = { "n", "v" }, "<C-A-l>", mc.nextCursor },

			-- Delete the main cursor.
			{ mode = { "n", "v" }, "<C-A-x>", mc.deleteCursor },

			-- Add and remove cursors with control + left click.
			{ mode = "n", "<c-leftmouse>", mc.handleMouse },

			-- Easy way to add and remove cursors using the main cursor.
			{ mode = { "n", "v" }, "<c-q>", mc.toggleCursor },

			-- Clone every cursor and disable the originals.
			{ mode = { "n", "v" }, "<leader><c-q>", mc.duplicateCursors },

			{
				mode = "n",
				"<C-esc>",
				function()
					if not mc.cursorsEnabled() then
						mc.enableCursors()
					elseif mc.hasCursors() then
						mc.clearCursors()
					else
						-- Default <esc> handler.
					end
				end,
			},

			{ mode = "n", "<leader>gv", mc.restoreCursors }, -- bring back cursors if you accidentally clear them
			{ mode = "n", "<leader>ga", mc.alignCursors }, -- Align cursor columns.

			-- Split visual selections by regex.

			-- Append/insert for each line of visual selections.
			{ mode = "v", "I", mc.insertVisual },
			{ mode = "v", "A", mc.appendVisual },

			-- match new cursors within visual selections by regex.
			{ mode = "v", "M", mc.matchCursors },

			-- Rotate visual selection contents.
			{
				mode = "v",
				"<leader>T",
				function()
					mc.transposeCursors(-1)
				end,
			},
			{
				mode = "v",
				"<leader>t",
				function()
					mc.transposeCursors(1)
				end,
			},

			-- Jumplist support
			{ mode = { "v", "n" }, "<c-i>", mc.jumpForward },
			{ mode = { "v", "n" }, "<c-o>", mc.jumpBackward },
		}
		return M
	end,
	opts = function()
		local hl = vim.api.nvim_set_hl
		hl(0, "MultiCursorCursor", { bg = "#48573c" })
		hl(0, "MultiCursorVisual", { bg = "#cc9999" })
		hl(0, "MultiCursorSign", { link = "SignColumn" })
		hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
		hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
		return {}
	end,
}
