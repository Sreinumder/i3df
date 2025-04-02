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
    vim.api.nvim_set_hl(0, 'MiniTablineCurrent', { fg = '#000000' , bg = '#f9f9f9', italic = true})
    vim.api.nvim_set_hl(0, 'MiniTablineVisible', { fg = '#5c5c5c' , bg = '#e5e5e5'})
    vim.api.nvim_set_hl(0, 'MiniTablineHidden', { fg = '#5c5c5c' , bg = '#e5e5e5'})
    vim.api.nvim_set_hl(0, 'MiniTablineModifiedCurrent', { fg = '#d75f00' , bg = '#f9f9f9', italic = true})
    vim.api.nvim_set_hl(0, 'MiniTablineModifiedVisible', { fg = '#9c6c4f' , bg = '#e5e5e5'})
    vim.api.nvim_set_hl(0, 'MiniTablineModifiedHidden', { fg = '#9c6c4f' , bg = '#e5e5e5'})
    vim.api.nvim_set_hl(0, 'MiniTablineTrunc', { fg = '#f75f00' , bg = '#e5e5e5'})
    vim.api.nvim_set_hl(0, 'MiniTablineFill', {  bg = '#e5e5e5'})
  end,
}
