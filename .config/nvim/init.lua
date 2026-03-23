vim.g.mapleader = " "
vim.g.maplocalleader = ";"

vim.cmd("autocmd BufEnter * set formatoptions-=cro")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
local lazy_config = require("lazy-config")

require("abbrev")
require("filetype")
require("globals")
if vim.g.started_by_firenvim == true then --firenvim
	require("firenvim")
elseif vim.g.vscode then --vscode
	require("vscodium")
else
	if vim.g.pluginless ~= 1 then
		local plugins = {
      { import = "plugins.buffer" },
			{ import = "plugins.ui" },
			{ import = "plugins.lsp" },
			{ import = "plugins.editing" },
			{ import = "plugins.essential" },
			{ import = "plugins.treesitter" },
		}
		require("lazy").setup(plugins, lazy_config)
	end
  require("options")
	require("lsp")
	-- require("mappings")
end
vim.schedule(function()
	require("mappings")
	require("autocmd")
end)
