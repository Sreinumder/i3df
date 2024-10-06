return {
  "brenton-leighton/multiple-cursors.nvim",
  version = "*",  -- Use the latest tagged version
  opts = {
    custom_key_maps = {
      {"n", {"<A-k>", "<A-Up>"}, function() require("mini.move").move_line("up") end},
      {"n", {"<A-j>", "<A-Down>"}, function() require("mini.move").move_line("down") end},
      {"n", {"<A-h>", "<A-Left>"}, function() require("mini.move").move_line("left") end},
      {"n", {"<A-l>", "<A-Right>"}, function() require("mini.move").move_line("right") end},

      {"x", {"<A-k>", "<A-Up>"}, function() require("mini.move").move_selection("up") end},
      {"x", {"<A-j>", "<A-Down>"}, function() require("mini.move").move_selection("down") end},
      {"x", {"<A-h>", "<A-Left>"}, function() require("mini.move").move_selection("left") end},
      {"x", {"<A-l>", "<A-Right>"}, function() require("mini.move").move_selection("right") end},
    },
    pre_hook = function()
      require('nvim-autopairs').disable()
      require("cmp").setup({enabled=false})
    end,
    post_hook = function()
      require('nvim-autopairs').enable()
      require("cmp").setup({enabled=true})
    end,
  },  -- This causes the plugin setup function to be called
  keys = {
    {"<C-A-j>", "<Cmd>MultipleCursorsAddDown<CR>", mode = {"n", "i", "x"}, desc = "Add a cursor then move down"},
    {"<C-A-k>", "<Cmd>MultipleCursorsAddUp<CR>", mode = {"n", "i", "x"}, desc = "Add a cursor then move up"},
    {"<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = {"n", "i"}, desc = "Add or remove a cursor"},
    {"<Leader>,mc", "<Cmd>MultipleCursorsAddMatches<CR>", mode = {"n", "x"}, desc = "Add cursors to the word under the cursor"},
  },
}
