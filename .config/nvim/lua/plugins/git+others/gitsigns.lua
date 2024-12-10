return {
  "lewis6991/gitsigns.nvim",
  event = "UIEnter",
  keys = {
    -- local gitsigns = require('gitsigns')
    {'n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        require('gitsigns').nav_hunk('next')
      end
    end, {desc = "next hunk/change"}},
    {'n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        require('gitsigns').nav_hunk('prev')
      end
    end, {desc = "prev hunk/change"}},
    -- Actions
    {mode= {'v'}, '<leader>hs', function() require('gitsigns').stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = "stage_hunk"}},
    {mode= {'v'}, '<leader>hr', function() require('gitsigns').reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = "reset_hunk"}},
    {'n', '<leader>hb', function() require('gitsigns').blame_line{full=true} end, {desc="blame_line"}},
    {'n', '<leader>hs', function() require('gitsigns').stage_hunk() end, {desc = "stage_hunk"}},
    {'n', '<leader>hr', function() require('gitsigns').reset_hunk() end, {desc = "reset_hunk"}},
    {'n', '<leader>hu', function() require('gitsigns').undo_stage_hunk() end, {desc = "unstage hunk"}},
    {'n', '<leader>hp', function() require('gitsigns').preview_hunk() end, {desc = "preview_hunk"}},
    {'n', '<leader>hS', function() require('gitsigns').stage_buffer() end, {desc = "stage_buffer"}},
    {'n', '<leader>hR', function() require('gitsigns').reset_buffer() end, {desc = "reset_buffer"}},
    {'n', '<leader>tb', function() require('gitsigns').toggle_current_line_blame() end, {desc="toggle_line_blame"}},
    {'n', '<leader>hd', function() require('gitsigns').diffthis() end, {desc="gitsigns_diffthis"}},
    {'n', '<leader>td', function() require('gitsigns').toggle_deleted() end, {desc="toggle_deleted"}},
    {'n', '<leader>hD', function() require('gitsigns').diffthis('~') end, {desc="diffthis~"}},
    -- {{'o', 'x'}, 'ic', ':<C-U>require('gitsigns') select_hunk<CR>', {desc="hunk txtobj"}}, -- Text object
  },
  opts = function()
    local M ={
      signs = {
        delete = { text = "󰍵" },
        changedelete = { text = "󱕖" },
      },
    }
    return M
  end,
}
