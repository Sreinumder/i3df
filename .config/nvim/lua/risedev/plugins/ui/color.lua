return {
  {
    -- "neanias/everforest-nvim",
    "Sreinumder/everforest-nvim",
    events = "VeryLazy",
    config = function()
      vim.cmd([[colorscheme everforest]])
    end,
  },
  -- {
  --   "EdenEast/nightfox.nvim",
  --   config = function()
  --     vim.cmd([[colorscheme nordfox]])
  --   end,
  --   opts = {},
  -- },
}
