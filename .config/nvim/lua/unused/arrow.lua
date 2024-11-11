return {
  "otavioschwanck/arrow.nvim",
  opts = {
    show_icons = true,
    leader_key = "<leader>f", -- Recommended to be a single key
    buffer_leader_key = "<leader>j", -- Per Buffer Mappings
    index_keys = "asdwuiop;q123",
    mappings = {
      edit = "e",
      delete_mode = "<A-d>",
      clear_all_items = "C",
      toggle = "f",
      open_vertical = "v",
      open_horizontal = "<A-v>",
      quit = "<esc>",
      remove = "x", -- only used if separate_save_and_remove is true
      next_item = "j",
      prev_item = "k"
    },
  },
  keys = {
    {"<leader>f"},
    {"<leader>j"},
    --   {"<leader>*", function() require("arrow.persist").toggle() end, {desc =  "arrow toggle" }},
    -- {"<leader>k", function() require("arrow.persist").previous() end, {desc =  "arrow prev" }},
    -- {"<leader>j", function() require("arrow.persist").next() end, {desc =  "arrow next" }},
  },
}
