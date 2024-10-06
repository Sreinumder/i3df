--┌────────────────────────────────────────────────┐
--│edit your filesystem like a normal Neovim buffer│
--└────────────────────────────────────────────────┘
return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
    })
    -- keymap.set('n', "<Leader>oe", function() vim.cmd("vsplit | wincmd l") require("oil").open() end, {desc = "oil file explorer"})
  end,
}
