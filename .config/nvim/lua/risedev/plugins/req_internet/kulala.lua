return {
    'mistweaverco/kulala.nvim',
    keys = {
      {"<leader>kr", function() require('kulala').run() end},
      {"<leader>kc", function() require('kulala').copy() end},
      {"<leader>kq", function() require('kulala').close() end},
      {"<leader>kt", function() require('kulala').toggle_view() end},
      {"<leader>kh", function() require('kulala').jump_prev() end},
      {"<leader>kl", function() require('kulala').jump_next() end},
    },
    config = function()
    vim.filetype.add({
      extension = {
        ['http'] = 'http',
      },
    })
    end,
}
