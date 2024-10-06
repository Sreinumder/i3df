return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup{}
    vim.option.keymap('n', <leader>tet, "ToggleTerm")
  end,
}
