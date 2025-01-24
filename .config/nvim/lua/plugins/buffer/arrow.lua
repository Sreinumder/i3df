return {
  "otavioschwanck/arrow.nvim",
  enabled = true,
  keys = {
    ",",
    "m",
    {"<leader>h", function() require("arrow.persist").previous() end, {desc = "arrow previous"}},
    {"<leader>l", function() require("arrow.persist").next() end, {desc = "arrow next"}},
    {"<C-s>", function() require("arrow.persist").toggle() end, {desc = "arrow toggle"}},
  },
  opts = {
    show_icons = true,
    leader_key = ',', -- Recommended to be a single key
    buffer_leader_key = 'm', -- Per Buffer Mappings
    mappings = {
      edit = "<S-Space>",
      delete_mode = "k",
      clear_all_items = "C",
      toggle = "<leader>", -- add to arrow list
      open_vertical = "l",
      open_horizontal = "j",
      quit = "<ESC>",
      next_item = "n",
      prev_item = "p"
    },
    save_key = "git_root", -- what will be used as root to save the bookmarks. Can be also `git_root` and `git_root_bare`.
    index_keys = "asdfqwerzxcv;jk123456789bnmZXVBNM,ghjklAFGHJKLtyuiopWRTYUIOP", -- keys mapped to bookmark index, i.e. 1st bookmark will be accessible by 1, and 12th - by c
    per_buffer_config = {
      sort_automatically = true, -- Auto sort buffer marks.
    },
    window = {
      width = 40
    }
  }
}
