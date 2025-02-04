return {
  "NeogitOrg/neogit",
  enabled = false,
  cmd = "Neogit",
  keys = {
    {"<M-g>", "<CMD>Neogit<CR>", {desc = "Neogit"}},
    {"<localleader>c", function() require('neogit').open({ "commit" }) end, {desc = "Neogit"}},
    {"<localleader>b", function() require('neogit').open({ "branch" }) end, {desc = "Neogit"}},
  },
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration
    "ibhagwan/fzf-lua",              -- optional
  },
  opts = {
    kind = "floating",
    notification_icon = "N",
    integrations = {
      fzf_lua = true,
    }
  }
}
