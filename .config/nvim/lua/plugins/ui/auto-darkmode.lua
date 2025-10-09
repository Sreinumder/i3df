return {
  "f-person/auto-dark-mode.nvim",
  lazy = false,
  priority = 100000,
  opts = {
    set_dark_mode = function()
      vim.api.nvim_set_option_value("background", "dark", {})
      vim.cmd('colorscheme github_dark_high_contrast')
    end,
    set_light_mode = function()
      vim.api.nvim_set_option_value("background", "light", {})
     vim.cmd('colorscheme github_light_high_contrast')
    end,
    update_interval = 3000,
    fallback = "dark"
  }
}
