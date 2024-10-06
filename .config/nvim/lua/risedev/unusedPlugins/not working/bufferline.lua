return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup({})
    end,
  },

  {
    "tiagovla/scope.nvim",
    config = function()
      require("scope").setup()
    end,
  },

  {
    "roobert/bufferline-cycle-windowless.nvim",
    config = function()
      require("bufferline-cycle-windowless").setup({
        default_enabled = true,
      })
    end,
  },
}
