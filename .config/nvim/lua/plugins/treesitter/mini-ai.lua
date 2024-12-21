return{
  { 'echasnovski/mini.ai',
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
  },
  { "chrisgrieser/nvim-various-textobjs",
    keys = {
      {mode={ "o", "x" }, "ih", '<cmd>lua require("various-textobjs").lineCharacterwise("inner")<CR>'},
      {mode={ "o", "x" }, "ah", '<cmd>lua require("various-textobjs").lineCharacterwise("outer")<CR>'},
      {mode={ "o", "x" }, "ij", '<cmd>lua require("various-textobjs").column()<CR>'},
      {mode={ "o", "x" }, "IR", '<cmd>lua require("various-textobjs").restOfIndentation()<CR>'},
      {mode={ "o", "x" }, "ii", '<cmd>lua require("various-textobjs").indentation("inner")<CR>'},
      {mode={ "o", "x" }, "ai", '<cmd>lua require("various-textobjs").indentation("outer")<CR>'},
      {mode={ "o", "x" }, "im", '<cmd>lua require("various-textobjs").indentation("outer")<CR>'},

      -- vim.keymap.set({ "o", "x" }, "is", '<cmd>lua require("various-textobjs").subword("inner")<CR>')
      -- vim.keymap.set({ "o", "x" }, "U", '<cmd>lua require("various-textobjs").url()<CR>')
      -- vim.keymap.set({ "o", "x" }, "as", '<cmd>lua require("various-textobjs").subword("outer")<CR>')
    },
  },
}
