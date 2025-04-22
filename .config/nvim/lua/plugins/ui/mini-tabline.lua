return {
  "echasnovski/mini.tabline",
  -- enabled = true,
  keys = {
    {"<Tab>", "<cmd>bnext<CR>", desc = "next buffer"},
    {"`", "<cmd>bnext<CR>", desc = "next buffer"},
    {"<S-Tab>", "<cmd>bprevious<CR>", desc = "previous buffer"},
    {"<A-w>", "<cmd>bdelete<CR>", desc = "previous buffer"},
  },
  opts = {},
  init = function()
    vim.api.nvim_set_hl(0, 'MiniTablineCurrent', { fg = '#f9f9f9' , bg = '#0 00000', italic = true})
    vim.api.nvim_set_hl(0, 'MiniTablineVisible', { fg = '#e5e5e5' , bg = '#3 c3c3c'})
    vim.api.nvim_set_hl(0, 'MiniTablineHidden', { fg = '#e5e5e5' , bg = '#3c 3c3c'})
    vim.api.nvim_set_hl(0, 'MiniTablineModifiedCurrent', { fg = '#f75f00' , bg = '#3c3c3c', italic = true})
    vim.api.nvim_set_hl(0, 'MiniTablineModifiedVisible', { fg = '#d75f00' , bg = '#3c3c3c'})
    vim.api.nvim_set_hl(0, 'MiniTablineModifiedHidden', { fg = '#9c6c4f' , bg = '#3c3c3c'})
    vim.api.nvim_set_hl(0, 'MiniTablineTrunc', { fg = '#f75f00' , bg = '#3c3 c3c'})
    vim.api.nvim_set_hl(0, 'MiniTablineFill', {  bg = '#3c3c3c'})
  end
}
