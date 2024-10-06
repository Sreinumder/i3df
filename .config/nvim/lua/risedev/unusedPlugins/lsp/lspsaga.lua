return {
  'nvimdev/lspsaga.nvim',
  ft = {'c','cpp', 'lua', 'rust', 'go'},
  dependencies = { 'nvim-treesitter',
    'nvim-web-devicons'
  },
  config = function()
    require('lspsaga').setup({})
  end,
}
