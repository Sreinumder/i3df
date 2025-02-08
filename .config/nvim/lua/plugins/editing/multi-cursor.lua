return {
  "jake-stewart/multicursor.nvim",
  event = "CursorMoved",
  keys = {
    { mode = { "n", "v" }, "<C-A-k>", "<cmd>lua require('multicursor-nvim').lineAddCursor(-1) <CR>" },
    { mode = { "n", "v" }, "<C-A-j>", "<cmd>lua require('multicursor-nvim').lineAddCursor(1) <CR>" },
    { mode = { "n", "v" }, "<C-A-h>", "<cmd>lua require('multicursor-nvim').prevCursor()<CR>" }, -- Rotate the main cursor.
    { mode = { "n", "v" }, "<C-A-l>", "<cmd>lua require('multicursor-nvim').nextCursor()<CR>" },
    { mode = { "n", "v" }, "<leader><C-A-K>", "<cmd>lua require('multicursor-nvim').lineSkipCursor(-1) <CR>" },
    { mode = { "n", "v" }, "<leader><C-A-J>", "<cmd>lua require('multicursor-nvim').lineSkipCursor(1) <CR>" },
    { mode = { "n", "v" }, "<C-A-3>", "<cmd>lua require('multicursor-nvim').matchAddCursor(-1) <CR>" }, -- Add or skip adding a new cursor by matching word/selection
    { mode = { "n", "v" }, "<C-A-S-3>", "<cmd>lua require('multicursor-nvim').matchSkipCursor(-1) <CR>" },
    { mode = { "n", "v" }, "<C-A-8>", "<cmd>lua require('multicursor-nvim').matchAddCursor(1) <CR>" },
    { mode = { "n", "v" }, "<C-A-S-8>", "<cmd>lua require('multicursor-nvim').matchSkipCursor(1) <CR>" },
    { mode = { "n", "v" }, "<C-A-/>", "<cmd>lua require('multicursor-nvim').matchAllAddCursors<CR>" }, -- Add all matches in the document
    { mode = { "n", "v" }, "<C-A-d>", "<cmd>lua require('multicursor-nvim').deleteCursor()<CR>" }, -- Delete the main cursor.

    -- Add and remove cursors with control + left click.
    { mode = "n", "<c-leftmouse>", "<cmd>lua require('multicursor-nvim').handleMouse()<CR>" },

    -- Easy way to add and remove cursors using the main cursor.
    { mode = { "n", "v" }, "<c-q>", "<cmd>lua require('multicursor-nvim').toggleCursor()<CR>" },

    -- Clone every cursor and disable the originals.
    { mode = { "n", "v" }, "<leader><c-q>", "<cmd>lua require('multicursor-nvim').duplicateCursors()<CR>" },

    {
      mode = "n",
      "<C-esc>",
      function()
        if not require("multicursor-nvim").cursorsEnabled() then
          require("multicursor-nvim").enableCursors()
        elseif require("multicursor-nvim").hasCursors() then
          require("multicursor-nvim").clearCursors()
        else
          -- Default <esc> handler.
        end
      end,
    },
    {
      mode = "n",
      ";<esc>",
      function()
        if not require("multicursor-nvim").cursorsEnabled() then
          require("multicursor-nvim").enableCursors()
        elseif require("multicursor-nvim").hasCursors() then
          require("multicursor-nvim").clearCursors()
        else
          -- Default <esc> handler.
        end
      end,
    },

    { mode = "n", ";gv", "<cmd>lua require('multicursor-nvim').restoreCursors()<CR>" }, -- bring back cursors if you accidentally clear them
    { mode = "n", "<leader>ga", "<cmd>lua require('multicursor-nvim').alignCursors()<CR>" }, -- Align cursor columns.
    --
    -- Split visual selections by regex.
    { mode = "x", "S", function() require('multicursor-nvim').splitCursors() end, },
    -- -- Append/insert for each line of visual selections.
    { mode = "x", "I", function() require('multicursor-nvim').insertVisual() end,},
    { mode = "x", "A", function() require('multicursor-nvim').appendVisual() end,},

    -- match new cursors within visual selections by regex.
    { mode = "x", "M", "<cmd>lua require('multicursor-nvim').matchCursors()<CR>" },
    --
    -- Rotate visual selection contents.
    {
      mode = "x",
      "<A-9>",
      function()
        require("multicursor-nvim").transposeCursors(-1)
      end,
    },
    {
      mode = "x",
      "<A-0>",
      function()
        require("multicursor-nvim").transposeCursors(1)
      end,
    },

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
