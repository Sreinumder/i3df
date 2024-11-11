--┌──────────────────────────────────────────────────────────────────────────────────────────┐
--│Call :FeMaco or require('femaco.edit').edit_code_block() with your cursor on a code-block.│
--│Edit the content, then save and/or close the popup to update the original buffer.         │
--└──────────────────────────────────────────────────────────────────────────────────────────┘
return {
  'AckslD/nvim-FeMaco.lua',
  ft = {"markdown", "org", "norg"},
  keys = {
    {"<leader>df", ":FeMaco<cr>"},
  },
  opts = {}
}
