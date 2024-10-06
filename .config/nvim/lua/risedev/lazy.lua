local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "risedev.plugins.ui" },
  { import = "risedev.plugins.editing" },
	{ import = "risedev.plugins.essential" },
	{ import = "risedev.plugins.tools" },
  { import = "risedev.plugins.git" },
	{ import = "risedev.plugins.buffer" },
	{ import = "risedev.plugins.note" },
	{ import = "risedev.plugins.treesitter" },
	{ import = "risedev.plugins.lsp" },
	{ import = "risedev.plugins.req_internet" },
}, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
