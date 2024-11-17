return {
  "gbprod/substitute.nvim",
  -- dependencies = { "gbprod/yanky.nvim" },
  events = { "UIEnter" },
  keys = {
    { "s", mode = { "n", "x" } },
    { "S", mode = { "n", "x" } },
    { "<A-s>", mode = { "n", "x" } },
  },
  config = function()
    require("substitute").setup({
      yank_substituted_text = false,
      preserve_cursor_position = false,
      highlight_substituted_text = { enabled = true, timer = 500, },
      range = { cursor_position = "end", },
      exchange = { preserve_cursor_position =  false, },
    })
    local keymap = vim.keymap
    keymap.set("n", "s", require("substitute").operator, { noremap = true })
    keymap.set("n", "ss", require("substitute").line, { noremap = true })
    keymap.set("n", "S", require("substitute").eol, { noremap = true })
    keymap.set("x", "s", require("substitute").visual, { noremap = true })
    keymap.set("n", "<A-s>", require("substitute.exchange").operator, { noremap = true })
    keymap.set("n", "<A-s><A-s>", require("substitute.exchange").line, { noremap = true })
    keymap.set("x", "<A-s>", require("substitute.exchange").visual, { noremap = true })
    keymap.set("n", "<A-s>c", require("substitute.exchange").cancel, { noremap = true })
    keymap.set("n", "<A-S>", require("substitute.range").operator, { noremap = true })
    keymap.set("x", "<A-S>", require("substitute.range").visual, { noremap = true })
    -- keymap.set("n", "<A-S>sr", require("substitute.range").word, { noremap = true })
    -- vim.keymap.set("n", "<leader>h",require('substitute.exchange').operator, )
    -- vim.keymap.set("n", "<A-g>l", "€üsiww.", {desc=""})
  end,
}
