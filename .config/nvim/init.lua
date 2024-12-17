vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
end

vim.opt.rtp:prepend(lazypath)
local lazy_config = require("configs.lazy")

require("abbrev")
require("filetype")
if vim.g.started_by_firenvim == true then --firenvim
  require("firenvim")
elseif vim.g.vscode then --vscode
  require("vscode")
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

end
vim.schedule(function()
  require("mappings")
  require("autocmd")
end)
