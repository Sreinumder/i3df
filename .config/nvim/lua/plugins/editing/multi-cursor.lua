return {
  "jake-stewart/multicursor.nvim",
  -- event = "CursorMoved",
  keys = {
    { mode = { "n", "v" }, "<C-A-k>", "<cmd>lua require('multicursor-nvim').lineAddCursor(-1) <CR>", desc = "Add mc above"},
    { mode = { "n", "v" }, "<C-A-j>", "<cmd>lua require('multicursor-nvim').lineAddCursor(1) <CR>", desc = "Add mc below"},
    { mode = { "n", "v" }, "<C-A-h>", "<cmd>lua require('multicursor-nvim').prevCursor()<CR>", desc = "prevCursor"},
    { mode = { "n", "v" }, "<C-A-l>", "<cmd>lua require('multicursor-nvim').nextCursor()<CR>", desc = "nextCursor"},
    { mode = { "n", "v" }, "<leader><C-A-K>", "<cmd>lua require('multicursor-nvim').lineSkipCursor(-1) <CR>", desc = "Skip cursor and above"},
    { mode = { "n", "v" }, "<leader><C-A-J>", "<cmd>lua require('multicursor-nvim').lineSkipCursor(1) <CR>", desc = "Skip cursor and below"},
    { mode = { "n", "v" }, "<C-A-3>", "<cmd>lua require('multicursor-nvim').matchAddCursor(-1) <CR>", desc = "add cursor on prev match"},
    { mode = { "n", "v" }, "<leader><C-A-3>", "<cmd>lua require('multicursor-nvim').matchSkipCursor(-1) <CR>", desc = "skip current match and next"},
    { mode = { "n", "v" }, "<C-A-8>", "<cmd>lua require('multicursor-nvim').matchAddCursor(1) <CR>", desc = "add cursor on next match"},
    { mode = { "n", "v" }, "<C-A-/>", "<cmd>lua require('multicursor-nvim').matchAllAddCursors()<CR>", desc = "Add all matches in the document"},
    { mode = { "n", "v" }, "<leader><C-A-8>", "<cmd>lua require('multicursor-nvim').matchSkipCursor(1) <CR>", desc = "skip current match and prev"},
    { mode = { "n", "v" }, "<C-A-d>", "<cmd>lua require('multicursor-nvim').deleteCursor()<CR>", desc = "Delete the main cursor."},
    { mode = "n", "<c-leftmouse>", "<cmd>lua require('multicursor-nvim').handleMouse()<CR>", desc = "Add and remove cursors with mouse"},

    { mode = { "n", "v" }, ";s", "<cmd>lua require('multicursor-nvim').toggleCursor()<CR>", desc = "pause/add cursor"},
    { mode = { "n", "v" }, ";;s", "<cmd>lua require('multicursor-nvim').duplicateCursors()<CR>", desc = "pause all mc + clone them"},
    { mode = "n", ";<A-;>",
      function()
        if not require("multicursor-nvim").cursorsEnabled() then
          require("multicursor-nvim").enableCursors()
        elseif require("multicursor-nvim").hasCursors() then
          require("multicursor-nvim").clearCursors()
        else -- Default <esc> handler.
        end
      end,
      desc = "unpause multi-cursor"
    },
    { mode = "n", ";gv", "<cmd>lua require('multicursor-nvim').restoreCursors()<CR>",  desc = "restoreCursors"}, -- bring back cursors if you accidentally clear them

    { mode = "n", "<leader>ga", "<cmd>lua require('multicursor-nvim').alignCursors()<CR>",  desc = "alignCursors"}, -- Align cursor columns.
    { mode = "x", "S", function() require('multicursor-nvim').splitCursors() end,  desc = "splitCursors"}, -- Split visual selections by regex.
    { mode = "x", "M", "<cmd>lua require('multicursor-nvim').matchCursors()<CR>",  desc = "matchCursors"}, -- match new cursors within visual selections by regex.

    { mode = "x", "<A-9>", function() require("multicursor-nvim").transposeCursors(-1) end,  desc = "transposeCursors"}, -- Rotate visual selection contents.
    { mode = "x", "<A-0>", function() require("multicursor-nvim").transposeCursors(1) end,  desc = "transposeCursors"},

    -- Append/insert for each line of visual selections.
    { mode = "x", "I", function() require('multicursor-nvim').insertVisual() end, desc = "insertVisual"},
    { mode = "x", "A", function() require('multicursor-nvim').appendVisual() end, desc = "appendVisual"},
    -- Jumplist support
    { mode = { "v", "n" }, "<c-i>", "<cmd>lua require('multicursor-nvim').jumpForward()<CR>", desc = "jump backward"},
    { mode = { "v", "n" }, "<c-o>", "<cmd>lua require('multicursor-nvim').jumpBackward()<CR>", desc = "jump backward" },
  },
  opts = function()
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { bg = "#484b3c" })
    hl(0, "MultiCursorVisual", { bg = "#38453c" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    return {}
  end,
}
