return {
  'harrisoncramer/jump-tag',
  ft = {"html", "js"},
  keys = {
    {'<leader>55', ':lua require("jump-tag").jumpParent()<CR>', { noremap = true, silent = true }},
    {'<leader>5n', ':lua require("jump-tag").jumpNextSibling()<CR>', { noremap = true, silent = true }},
    {'<leader>5p', ':lua require("jump-tag").jumpPrevSibling()<CR>', { noremap = true, silent = true}},
    {'<leader>5c', ':lua require("jump-tag").jumpChild()<CR>', { noremap = true, silent = true}},
  }
}
