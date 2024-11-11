return {
  "luckasRanarison/nvim-devdocs",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = "DevdocsOpen",
  keys = {
    {"<leader>ddo", ":DevdocsOpen<cr>"},
    {"<leader>ddi", ":DevdocsInstall<cr>"},
    {"<leader>ddc", ":DevdocsOpenCurrent<cr>"},
  },
  opts = {}
}
