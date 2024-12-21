return {
  "lewis6991/gitsigns.nvim",
  event = "UIEnter",
  keys = {
    -- local gitsigns = require('gitsigns')
    {']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        require('gitsigns').nav_hunk('next')
      end
    end, {desc = "next hunk/change"}},
    {'[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        require('gitsigns').nav_hunk('prev')
      end
    end, {desc = "prev hunk/change"}},
    -- Actions
    {mode= {'v'}, '<leader>hs', function() require('gitsigns').stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = "stage_hunk"}},
    {mode= {'v'}, '<leader>hr', function() require('gitsigns').reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = "reset_hunk"}},
    {'<leader>hB', function() require('gitsigns').blame_line{full=true} end, {desc="blame_line"}},
    {'<leader>hb', function() require('gitsigns').blame() end, {desc="blame_line"}},
    {'<leader>hs', function() require('gitsigns').stage_hunk() end, {desc = "stage_hunk"}},
    {'<leader>hr', function() require('gitsigns').reset_hunk() end, {desc = "reset_hunk"}},
    {'<leader>hu', function() require('gitsigns').undo_stage_hunk() end, {desc = "unstage hunk"}},
    {'<leader>hp', function() require('gitsigns').preview_hunk() end, {desc = "preview_hunk"}},
    {'<leader>hS', function() require('gitsigns').stage_buffer() end, {desc = "stage_buffer"}},
    {'<leader>hR', function() require('gitsigns').reset_buffer() end, {desc = "reset_buffer"}},
    {'<leader>hR', function() require('gitsigns').undo_stage_buffer() end, {desc = "reset_buffer"}},
    {'<leader>tb', function() require('gitsigns').toggle_current_line_blame() end, {desc="toggle_line_blame"}},
    {'<leader>hd', function() require('gitsigns').diffthis() end, {desc="gitsigns_diffthis"}},
    {'<leader>td', function() require('gitsigns').toggle_deleted() end, {desc="toggle_deleted"}},
    {'<leader>hD', function() require('gitsigns').diffthis('~') end, {desc="diffthis~"}},
    {mode={'o', 'x'}, 'ic', ':<C-U>Gitsigns select_hunk<CR>', {desc="hunk txtobj"}}, -- Text object
  },
  opts = function()
    local M ={
		count_chars = { "", "󰬻", "󰬼", "󰬽", "󰬾", "󰬿", "󰭀", "󰭁", "󰭂", ["+"] = "󰿮" },
      signs = {
        delete = { text = "󰍵" },
        changedelete = { text = "󱕖" },
      },
    }
    return M
  end,
}

-- return { 
--   'echasnovski/mini.diff',
-- 	event = "UIEnter",
--   -- version = false,
-- }
