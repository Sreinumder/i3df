vim.cmd([[autocmd BufEnter * set formatoptions-=cro]])

vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")

if vim.g.vscode then
  require("lazy").setup({
    { import = "plugins.treesitter" },
    { import = "plugins.editing" },
    { import = "plugins.vscode" },
  }, lazy_config)
  require("options")
  require("mappings")
  require("hacks")
else
  local plugins = {
    { import = "nvchad.plugins" },
    { import = "plugins.ui" },
    { import = "plugins.note" },
    { import = "plugins.buffer" },
    { import = "plugins.editing" },
    { import = "plugins.essential" },
    { import = "plugins.treesitter" },
    { import = "plugins.git+others" },
    { import = "plugins.tools" },
  }
  require("lazy").setup(plugins, lazy_config)

  dofile(vim.g.base46_cache .. "defaults")
  dofile(vim.g.base46_cache .. "statusline")

  require("options")
  require("mappings")
  require("hacks")

  vim.schedule(function()
  require("mappings")
    require("autocmd")
  end)
end
