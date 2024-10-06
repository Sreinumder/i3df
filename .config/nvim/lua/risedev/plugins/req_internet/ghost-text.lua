return {
  'subnut/nvim-ghost.nvim',
  keys = {{"<leader><leader>gh", ":lua let g:nvim_ghost_server_port = 4001" }},
  config = function()
    vim.cmd("let g:nvim_ghost_server_port = 4001")
    vim.cmd("let g:nvim_ghost_autostart = 0")
  end,
 }
