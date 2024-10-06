vim.cmd([[autocmd BufEnter * set formatoptions-=cro]]) -- disables auto comment on pressiong o or enter on comment

-- https://www.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance/
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    if not normal.bg then return end
    io.write(string.format("\027]11;#%06x\027\\", normal.bg))
  end,
})
vim.api.nvim_create_autocmd("UILeave", {
  callback = function() io.write("\027]111\027\\") end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*.conf",
	command = "setlocal filetype=conf | setlocal commentstring=#%s",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("mariasolos/yank_highlight", { clear = true }),
	desc = "Highlight on yank",
	callback = function()
		-- Setting a priority higher than the LSP references one.
		vim.highlight.on_yank({ higroup = "Visual", priority = 250 })
	end,
})

vim.api.nvim_create_autocmd("CmdwinEnter", {
	group = vim.api.nvim_create_augroup("mariasolos/execute_cmd_and_stay", { clear = true }),
	desc = "Execute command and stay in the command-line window",
	callback = function(args)
		vim.keymap.set({ "n", "i" }, "<S-CR>", "<cr>q:k", { buffer = args.buf })
	end,
})

-- vim.api.nvim_create_autocmd("InsertEnter", {
-- 	group = vim.api.nvim_create_augroup("risedev/zz_on_insert", { clear = true }),
-- 	desc = "centers the cursor on insert mode",
--   command =  "norm! zz"
-- })

-- {bg  = "#2D353B" }) background colour
-- vim.api.nvim_create_autocmd({ "InsertEnter"}, {
--   callback = function()
--     vim.api.nvim_set_hl(0, "CursorLine", {bg  = "#3D4c3B" })
--     vim.api.nvim_set_hl(0, "CursorColumn", {bg  = "#3D4c3B" })
--   end
-- })
-- vim.api.nvim_create_autocmd({"InsertLeave" }, {
--   callback = function()
--     vim.api.nvim_set_hl(0, "CursorLine", {bg  = "#383E48" })
--     vim.api.nvim_set_hl(0, "CursorColumn", {bg  = "#383E48" })
--   end
-- })

-- augroup numbertoggle
--     autocmd!
--     autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
--     autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
-- augroup END

-- vim.api.nvim_create_autocmd("cdToThisFilePath", {
-- 	group = vim.api.nvim_create_augroup("risedev/cdToThisFile", { clear = true }),
-- 	desc = "cds to the current file buffer",
-- 	callback = function(args)
-- 		vim.keymap.set({ "n", "i" }, "<S-CR>", "<cr>q:", { buffer = args.buf })
-- 	end,
-- })

-- Automatically reload the file if it is changed outside of Nvim, see https://unix.stackexchange.com/a/383044/221410.
-- It seems that `checktime` does not work in command line. We need to check if we are in command
-- line before executing this command, see also https://vi.stackexchange.com/a/20397/15292 .
-- vim.api.nvim_create_augroup("auto_read", { clear = true })

-- Resize all windows when we resize the terminal
-- vim.api.nvim_create_autocmd("VimResized", {
-- 	group = vim.api.nvim_create_augroup("win_autoresize", { clear = true }),
-- 	desc = "autoresize windows on resizing operation",
-- 	command = "wincmd =",
-- })

-- Disable sql omni completion, it is broken.
vim.g.loaded_sql_completion = 1
