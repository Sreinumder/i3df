local lazy_config = require("configs.lazy")
vim.o.laststatus = 0
vim.g.firenvim_config.localSettings['.*'] = { takeover = 'never' }
vim.keymap.set({"n", "x"}, "<A-e>", "ZZ", { desc = "fire-nvim close" })
vim.keymap.set("i", "<A-e>", "<ESC>ZZ", { desc = "fire-nvim close" })
vim.api.nvim_create_autocmd({'BufEnter'}, {
  pattern = "github.com_*.txt",
  command = "set filetype=markdown"
})
vim.api.nvim_create_autocmd({'BufEnter'}, {
  pattern = "leetcode.com_*.txt",
  command = "set filetype=python"
})
require("lazy").setup({
  { import = "plugins.editing" },
  {
    'glacambre/firenvim',
    build = ":call firenvim#install(0)",
    lazy = false,
  },
}, lazy_config)
require("options")
require("mappings")
require("hacks")
