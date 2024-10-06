return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  opts = {},
  events = {"VeryLazy"},
  keys = {
    { "<leader>tth", ":Hardtime toggle<CR>", { desc = "Toggle hardtime" } },
  }
}
