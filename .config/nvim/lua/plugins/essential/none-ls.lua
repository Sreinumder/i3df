return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "mason.nvim",
    "nvimtools/none-ls-extras.nvim",
    "davidmh/cspell.nvim",
  },
  opts = function()
    local none_ls = require("null-ls")
    local cspell = require("cspell")
    return {
      sources = {
        none_ls.builtins.formatting.stylua,
        none_ls.builtins.completion.spell,
        require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
        cspell.diagnostics,
        cspell.code_actions,
      },
    }
   end,
}
