local autocmd = vim.api.nvim_create_autocmd

autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})

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

-- comment for .conf files
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*.conf",
	command = "setlocal filetype=conf | setlocal commentstring=#%s",
})

-- yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("yank_highlight", { clear = true }),
	desc = "Highlight on yank",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", Timeout = 700,  priority = 250 })
	end,
})

-- Execute command and stay in the command-line window
vim.api.nvim_create_autocmd("CmdwinEnter", {
	group = vim.api.nvim_create_augroup("mariasolos/execute_cmd_and_stay", { clear = true }),
	desc = "Execute command and stay in the command-line window",
	callback = function(args)
		vim.keymap.set({ "n", "i" }, "<S-CR>", "<cr>q:k", { buffer = args.buf })
	end,
})

-- Disable sql omni completion, it is broken.
vim.g.loaded_sql_completion = 1
vim.g.preserve_cursor_pos = false
