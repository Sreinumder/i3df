vim.cmd([[autocmd BufEnter * set formatoptions-=cro]])
require("risedev.core")
require("risedev.lazy")
require("risedev.autocmds")

if vim.g.neovide then
	-- vim.o.guifont = "Source Code Pro:h14"
	vim.g.neovide_cursor_vfx_mode = ""
	vim.g.neovide_scale_factor = 1.0
	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end
	vim.keymap.set("n", "<C-+>", function()
		change_scale_factor(1.25)
	end)
	vim.keymap.set("n", "<C-->", function()
		change_scale_factor(1 / 1.25)
	end)

	-- -- Helper function for transparency formatting
	local alpha = function()
	-- 	-- return string.format("%x", math.floor(255 * vim.g.neovide_transparency_point or 0.8))
    return "ff"
	end
	-- -- Set transparency and background color (title bar color)
	vim.g.neovide_transparency = 0.8
	vim.g.neovide_transparency_point = 0.8
	vim.g.neovide_background_color = "#0f1117" .. alpha()
	-- -- Add keybinds to change transparency
	local change_transparency = function(delta)
		vim.g.neovide_transparency_point = vim.g.neovide_transparency_point + delta
		vim.g.neovide_background_color = "#0f1117" .. alpha()
	end
	vim.keymap.set({ "n", "v", "o" }, "<A-t>+", function()
		change_transparency(0.1)
	end, {desc = "neovide transparency 0.1"})
	vim.keymap.set({ "n", "v", "o" }, "<A-t>-", function()
		change_transparency(-0.1)
	end, {desc = "neovide transparency -0.1"})
end
