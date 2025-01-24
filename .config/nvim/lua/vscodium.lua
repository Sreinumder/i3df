
require("lazy").setup({
  { import = "plugins.treesitter" },
  { import = "plugins.editing" },
  -- { import = "plugins.git+others" },
  { import = "plugins.vscode" },
  {
    'vscode-neovim/vscode-multi-cursor.nvim',
    event = 'VeryLazy',
    cond = not not vim.g.vscode,
    config = function()
      local cursors = require('vscode-multi-cursor')
      local map = vim.keymap.set
      map({ 'n', 'x' }, 'mc', cursors.create_cursor, { expr = true, desc = 'Create cursor' })
      map({ 'n' }, 'mcc', cursors.cancel, { desc = 'Cancel/Clear all cursors' })
      map({ 'n', 'x' }, 'mi', cursors.start_left, { desc = 'Start cursors on the left' })
      map({ 'n', 'x' }, 'mI', cursors.start_left_edge, { desc = 'Start cursors on the left edge' })
      map({ 'n', 'x' }, 'ma', cursors.start_right, { desc = 'Start cursors on the right' })
      map({ 'n', 'x' }, 'mA', cursors.start_right, { desc = 'Start cursors on the right' })
      map({ 'n' }, '[mc', cursors.prev_cursor, { desc = 'Goto prev cursor' })
      map({ 'n' }, ']mc', cursors.next_cursor, { desc = 'Goto next cursor' })
      map({ 'n' }, 'mcs', cursors.flash_char, { desc = 'Create cursor using flash' })
      map({ 'n' }, 'mcw', cursors.flash_word, { desc = 'Create selection using flash' })
    end,
  }
}, lazy_config)
require("options")
require("mappings")
require("hacks")
local map = vim.keymap.set
map("n", "<leader>fw", function()
  require("vscode").action("periscope.search")
end, {desc = "open periscope"})
map("n", "<leader>ff", function()
  require("vscode").action("workbench.action.quickOpen")
end, {desc = "open periscope"})
map("n", "<leader>fs", function()
  require("vscode").action("periscope.search")
end, {desc = "open periscope"})
-- map("n", "<A-w>", function()
--   require("vscode").action("workbench.action.closeWindow")
-- end, {desc = "open periscope"})
