return {
  "nvim-lua/plenary.nvim",
  {
    "nvchad/base46",
    build = function()
      require("base46").load_all_highlights()
    end,
  },
}
