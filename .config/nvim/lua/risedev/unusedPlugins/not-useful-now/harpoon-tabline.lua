return {
    "jasonpanosso/harpoon-tabline.nvim",
    dependencies = { "ThePrimeagen/harpoon" },
    config = function()
      require('harpoon-tabline').setup()
    end,
}
