return {
  "oskarrrrrrr/symbols.nvim",
  keys = {
    {"<leader>,,", ":SymbolsToggle<CR>"},
  },
  cmd = {"Symbols", "SymbolsClose", "SymbolsToggle"},
  opts = function()
    local r = require("symbols.recipes")
    require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, { })
    return {}
  end,
}
