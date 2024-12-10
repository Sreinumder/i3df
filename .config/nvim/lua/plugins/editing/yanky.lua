return {
  "gbprod/yanky.nvim",
  keys = {
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
    { "p", "<Plug>(YankyPutAfter)", mode = {"n","x"}},
    {"P", "<Plug>(YankyPutBefore)" , mode = {"n","x"}, },
    {"gp", "<Plug>(YankyGPutAfter)", mode = {"n","x"}, },
    {"gP", "<Plug>(YankyGPutBefore)", mode = {"n","x"}, },
    {"<c-p>", "<Plug>(YankyPreviousEntry)", mode = "n" },
    {"<c-n>", "<Plug>(YankyNextEntry)"    , mode = "n" },
    {"<leader>,p", 
      function()
        vim.g.preserve_cursor_pos = not vim.g.preserve_cursor_pos
        require("substitute").setup({preserve_cursor_position = vim.g.preserve_cursor_pos})
        require("yanky").setup({preserve_cursor_position = {enabled = vim.g.preserve_cursor_pos}})
      end,
    }
  },
  opts = {
    ring = {
      history_length = 100,
      storage = "shada",
      storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db", -- Only for sqlite storage
      sync_with_numbered_registers = true,
      cancel_event = "update",
      ignore_registers = { "_" },
      update_register_on_cycle = false,
    },
    picker = {
      select = {
        action = nil, -- nil to use default put action
      },
      telescope = {
        use_default_mappings = true, -- if default mappings should be used
        mappings = nil, -- nil to use default mappings or no mappings (see `use_default_mappings`)
      },
    },
    system_clipboard = {
      sync_with_ring = true,
      clipboard_register = nil,
    },
    highlight = {
      on_put = true,
      on_yank = true,
      timer = vim.g.change_hl_duration,
    },
    preserve_cursor_position = {enabled = true,},
    textobj = {
      enabled = true,
    },
  },
}
