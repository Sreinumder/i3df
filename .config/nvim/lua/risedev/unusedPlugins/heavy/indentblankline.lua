--┌─────────────────────────────────────────────────────┐
--│func(){                                              │
--││ inserts indent line like at the start of this line │
--│}                                                    │
--└─────────────────────────────────────────────────────┘
return { 
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    enabled = true,
    show_exact_scope = true,
  },
  config = function()
    require("ibl").update {
      indent = {
        -- char = "┋",
        char = "┃",
        -- char = "║",
        -- char = "█",
        highlight = { "Whitespace", "NonText", "Function", "Label" },
      },
      scope = {
        show_start = false,
        show_end = false,
        show_exact_scope = false,
        -- highlight = { "Whitespace", "NonText", "Function", "Label" },
      }
    }
    vim.keymap.set('n', '<leader>tin', ':IBLToggle<CR>', {desc = "toggle indent-blankline"})
  end,
}
