return {
	"chrisgrieser/nvim-various-textobjs",
	keys = function()
		local function delete_indentation() -- dsi
			require("various-textobjs").indentation("outer", "outer")
			local indentationFound = vim.fn.mode():find("V")
			if not indentationFound then
				return
			end
			vim.cmd.normal({ "<", bang = true }) -- dedent indentation
			local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1] -- delete surrounding lines
			local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1]
			vim.cmd(tostring(endBorderLn) .. " delete") -- delete first so line index is not shifted
			vim.cmd(tostring(startBorderLn) .. " delete")
		end
		local function yank_surrounding() --ysi
			local startPos = vim.api.nvim_win_get_cursor(0)

			-- identify start- and end-border
			require("various-textobjs").indentation("outer", "outer")
			local indentationFound = vim.fn.mode():find("V")
			if not indentationFound then
				return
			end
			vim.cmd.normal({ "V", bang = true }) -- leave visual mode so the '< '> marks are set
			local startLn = vim.api.nvim_buf_get_mark(0, "<")[1] - 1
			local endLn = vim.api.nvim_buf_get_mark(0, ">")[1] - 1
			local startLine = vim.api.nvim_buf_get_lines(0, startLn, startLn + 1, false)[1]
			local endLine = vim.api.nvim_buf_get_lines(0, endLn, endLn + 1, false)[1]
			vim.fn.setreg('"', startLine .. "\n" .. endLine .. "\n")

			-- highlight yanked text
			local ns = vim.api.nvim_create_namespace("ysi")
			vim.api.nvim_buf_add_highlight(0, ns, "IncSearch", startLn, 0, -1)
			vim.api.nvim_buf_add_highlight(0, ns, "IncSearch", endLn, 0, -1)
			vim.defer_fn(function()
				vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
			end, 1000)
			vim.api.nvim_win_set_cursor(0, startPos)
		end
		return {
			{ mode = { "o", "x" }, "g;", '<cmd>lua require("various-textobjs").lastChange()<CR>' },
			{ mode = { "o", "x" }, "ih", '<cmd>lua require("various-textobjs").lineCharacterwise("inner")<CR>' },
			-- { mode = { "o", "x" }, "ah", '<cmd>lua require("various-textobjs").lineCharacterwise("outer")<CR>' },
			-- { mode = { "o", "x" }, "iu", '<cmd>lua require("various-textobjs").number("inner")<CR>' },
			{ mode = { "o", "x" }, "m", '<cmd>lua require("various-textobjs").chainMember("outer")<CR>' },
			{ mode = { "o", "x" }, "ij", '<cmd>lua require("various-textobjs").column()<CR>' },
			{ mode = { "o", "x" }, "IR", '<cmd>lua require("various-textobjs").restOfIndentation()<CR>' },
			{
				mode = { "o", "x" },
				"ii",
				"<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>",
				 desc = "inner-inner indentation textobj" ,
			},
			{
				mode = { "o", "x" },
				"ai",
				function()
					local ft = vim.bo.filetype -- Get the current buffer's filetype
					if ft == "python" or ft == "python2" then
						require("various-textobjs").indentation("outer", "inner")
					else
						require("various-textobjs").indentation("outer", "outer")
					end
				end,
				 desc = "outer-inner indentation textobj" ,
			},
			{ "dsi", delete_indentation,  desc = "Delete Surrounding Indentation"  },
			{ "ysi", yank_surrounding,  desc = "Yank surrounding indentation"  },

			{ mode = { "o", "x" }, "is", '<cmd>lua require("various-textobjs").subword("inner")<CR>' },
			{ mode = { "o", "x" }, "gx", '<cmd>lua require("various-textobjs").url()<CR>' },
		}
	end,
}
