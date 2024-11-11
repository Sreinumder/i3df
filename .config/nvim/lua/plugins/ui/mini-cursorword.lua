return {
  "echasnovski/mini.cursorword",
  version = "*",
  -- event = "CursorMoved",
  keys = {
    {"<leader>,cw",
      function()
        vim.api.nvim_set_hl(0, 'MiniCursorwordCurrent', {})
        if vim.g.minicursorword_disable then
          vim.g.minicursorword_disable = false
        else
          vim.g.minicursorword_disable = true
        end
      end, desc="toggle mini.cursorword"}
  },
  opts = {},
}
-- mini
