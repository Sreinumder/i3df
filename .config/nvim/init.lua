vim.cmd([[autocmd BufEnter * set formatoptions-=cro]]) -- disables auto comment on pressiong o or enter on comment
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
	{ import = "nvchad.plugins" },
	{ import = "plugins.ui" },
	{ import = "plugins.buffer" },
	{ import = "plugins.editing" },
	{ import = "plugins.essential" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.note" },
	{ import = "plugins.req_internet" },
	{ import = "plugins.tools" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"

vim.schedule(function()
  require "mappings"
	require "autocmd"
end)
