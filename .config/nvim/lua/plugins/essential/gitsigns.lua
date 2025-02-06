return {
  "lewis6991/gitsigns.nvim",
  event = "CursorMoved",
  keys = {
    {
      "]c",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          require("gitsigns").nav_hunk("next")
        end
      end,
       desc = "next hunk/change" ,
    },
    {
      "[c",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          require("gitsigns").nav_hunk("prev")
        end
      end,
       desc = "prev hunk/change" ,
    },
    { "<localleader>hs", function() require("gitsigns").stage_hunk() end,  desc = "stage_hunk" , },
    { "<localleader>hr", function() require("gitsigns").reset_hunk() end,  desc = "reset_hunk" ,
    { mode = { "v" }, "<localleader>hs", function()require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })end,  desc = "stage_hunk" ,},
    { mode = { "v" }, "<localleader>hr", function()require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })end,  desc = "reset_hunk" , },

    { "<localleader>bp", function() require("gitsigns").preview_hunk() end,  desc = "preview_hunk" , },
    { "<localleader>bs", function() require("gitsigns").stage_buffer() end,  desc = "stage_buffer" ,},
    { "<localleader>br", function() require("gitsigns").reset_buffer() end,  desc = "reset_buffer" ,},

    -- blame
    { "<localleader>hB", function() require("gitsigns").blame_line({ full = true }) end,  desc = "blame_line" , },
    { "<localleader>hb", function() require("gitsigns").blame() end,  desc = "blame_line" , }, },

    -- Diff
    {"<localleader>td", function() require("gitsigns").toggle_deleted() end,  desc = "toggle_deleted" ,},
    {"<localleader>hd", function() require("gitsigns").diffthis() end,  desc = "gitsigns_diffthis" ,},
    {"<localleader>hD", function() require("gitsigns").diffthis("~") end,  desc = "diffthis~" ,},

    -- text-obj
    { mode = { "o", "x" }, "ic", ":<C-U>Gitsigns select_hunk<CR>",  desc = "hunk txtobj"  }, -- Text object

    -- toggle
    {"<leader>,b", function() require("gitsigns").toggle_current_line_blame() end,  desc = "toggle_line_blame" ,},
  },
  opts = function()
    local M = {
      signcolumn = false,
      numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false,
    }
    return M
  end,
}
