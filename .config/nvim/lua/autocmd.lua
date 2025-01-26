local autocmd = vim.api.nvim_create_autocmd

autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
	callback = function(args)
		local file = vim.api.nvim_buf_get_name(args.buf)
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

		if not vim.g.ui_entered and args.event == "UIEnter" then
			vim.g.ui_entered = true
		end

		if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
			vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
			vim.api.nvim_del_augroup_by_name("NvFilePost")

			vim.schedule(function()
				vim.api.nvim_exec_autocmds("FileType", {})

				if vim.g.editorconfig then
					require("editorconfig").config(args.buf)
				end
			end)
		end
	end,
})

autocmd("Filetype", {
	pattern = "*",
	callback = function()
		vim.opt_local.fo:remove({ "c", "r", "o" })
	end,
	desc = "disable comment in newline",
})

autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local line = vim.fn.line("'\"")
		if
			line > 1
			and line <= vim.fn.line("$")
			and vim.bo.filetype ~= "commit"
			and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
		then
			vim.cmd('normal! g`"')
		end
	end,
})

-- https://www.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance/
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
	callback = function()
		local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
		if not normal.bg then
			return
		end
		io.write(string.format("\027]11;#%06x\027\\", normal.bg))
	end,
})
vim.api.nvim_create_autocmd("UILeave", {
	callback = function()
		io.write("\027]111\027\\")
	end,
})

-- comment for .conf files
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*.conf",
	command = "setlocal filetype=conf | setlocal commentstring=#%s",
})

-- get current buffer absolute path
vim.api.nvim_create_user_command("QuickLook", function()
	local path = vim.fn.expand("%:p")
	require("core.utils").open_file_with_quicklook(path)
end, { nargs = 0, force = true })

-- -- yank highlight
-- vim.api.nvim_create_autocmd("TextYankPost", {
-- 	group = vim.api.nvim_create_augroup("yank_highlight", { clear = true }),
-- 	desc = "Highlight on yank",
-- 	callback = function()
-- 		vim.highlight.on_yank({ higroup = "IncSearch", Timeout = 700,  priority = 250 })
-- 	end,
-- })

-- Execute command and stay in the command-line window
vim.api.nvim_create_autocmd("CmdwinEnter", {
	group = vim.api.nvim_create_augroup("mariasolos/execute_cmd_and_stay", { clear = true }),
	desc = "Execute command and stay in the command-line window",
	callback = function(args)
		vim.keymap.set({ "n", "i" }, "<S-CR>", "<cr>q:k", { buffer = args.buf })
	end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("json_conceal", { clear = true }),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- local lastplace = vim.api.nvim_create_augroup("LastPlace", {})
-- vim.api.nvim_clear_autocmds({ group = lastplace })
-- vim.api.nvim_create_autocmd("BufReadPost", {
--     group = lastplace,
--     pattern = { "*" },
--     desc = "remember last cursor place",
--       callback = function()
--         local filetype = vim.opt.filetype:get()
--         if (filetype == "gitcommit" or filetype == "gitrebase") then
--           vim.cmd([[ exe 'normal! gg' ]])
--         elseif (vim.fn.line("'"") > 1 and vim.fn.line("'"") <= vim.fn.line("$")) then
--             vim.cmd([[ exe 'normal! g`"' ]])
--         end
--       end, })

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
	pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.api.nvim_create_user_command('Messages', function()
  scratch_buffer = vim.api.nvim_create_buf(false, true)
  vim.bo[scratch_buffer].filetype = 'vim'
  local messages = vim.split(vim.fn.execute('messages', 'silent'), '\n')
  vim.api.nvim_buf_set_text(scratch_buffer, 0, 0, 0, 0, messages)
  vim.cmd('vertical sbuffer ' .. scratch_buffer)
  vim.opt_local.wrap = true
  vim.bo.buflisted = false
  vim.bo.bufhidden = 'wipe'
  vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = scratch_buffer })
end, {})
