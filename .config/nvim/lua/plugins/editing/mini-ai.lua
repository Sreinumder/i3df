return{
  'echasnovski/mini.ai',
  version = '*',
  keys = {
    { "i", mode={ "n", "x" } },
    { "a", mode={ "n", "x" } },
  },
  opts = function()
    local spec_treesitter = require('mini.ai').gen_spec.treesitter
    local M = {
      custom_textobjects = {
        F = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
        o = spec_treesitter({
          a = { '@conditional.outer', '@loop.outer' },
          i = { '@conditional.inner', '@loop.inner' },
        })
      },
      n_lines = 50,
    }
    return M
  end,
}
