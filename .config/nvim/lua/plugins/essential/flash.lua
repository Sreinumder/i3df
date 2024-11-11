return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    { "<leader>;", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "<A-f>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "<A-F>k", mode = "n", function() require("flash").remote() end, desc = "Remote Flash" },
    -- { "<leader>;d", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<A-f>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
