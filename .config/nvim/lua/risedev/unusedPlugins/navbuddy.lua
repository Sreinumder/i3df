return {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
        "neovim/nvim-lspconfig",
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
        "numToStr/Comment.nvim",        -- Optional
        "nvim-telescope/telescope.nvim" -- Optional
    },
    opts = {},
    config = function()
      local navbuddy = require("nvim-navbuddy")
      require("lspconfig").clangd.setup {
          on_attach = function(client, bufnr)
              navbuddy.attach(client, bufnr)
          end
      }
    end,
}
