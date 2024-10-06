return {
  'sudormrfbin/cheatsheet.nvim',
  dependencies = {
    {'nvim-telescope/telescope.nvim'},
    {'nvim-lua/popup.nvim'},
    {'nvim-lua/plenary.nvim'},
  },
  config = function()
    require('cheatsheet').setup()
    vim.keymap.set('n', '<leader>ch', ':Cheatsheet<cr>', {desc = "cheatsheet"})
  end,
}
