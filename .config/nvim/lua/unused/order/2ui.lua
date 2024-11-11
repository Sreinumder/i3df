return {
  {
    "nvchad/ui",
    lazy = false,
    config = function()
      require "nvchad"
    end,
  },


  {
    'tzachar/highlight-undo.nvim',
    opts = {},
    keys = {'u', '<C-r>'}
  },

  "nvzone/volt"
}
