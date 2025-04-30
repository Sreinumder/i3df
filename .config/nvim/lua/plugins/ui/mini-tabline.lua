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
    vim.api.nvim_set_hl(0, 'MiniTablineCurrent', { fg = '#f9f9f9' , bg = '#3c3c3c', italic = true})
    vim.api.nvim_set_hl(0, 'MiniTablineVisible', { fg = '#aaaaaa' , bg = '#2b3339'})
    vim.api.nvim_set_hl(0, 'MiniTablineHidden', { fg = '#aaaaaa' , bg = '#2b3339'})
    vim.api.nvim_set_hl(0, 'MiniTablineModifiedCurrent', { fg = '#f75f00' , bg = '#2b3339', italic = true})
    vim.api.nvim_set_hl(0, 'MiniTablineModifiedVisible', { fg = '#d75f00' , bg = '#2b3339'})
    vim.api.nvim_set_hl(0, 'MiniTablineModifiedHidden', { fg = '#9c6c4f' , bg = '#2b3339'})
    vim.api.nvim_set_hl(0, 'MiniTablineTrunc', { fg = '#f75f00' , bg = '#2b3339'})
    vim.api.nvim_set_hl(0, 'MiniTablineFill', {  bg = '#2b3339'})
  end
}
