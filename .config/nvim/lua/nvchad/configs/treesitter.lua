pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

return {
  ensure_installed = { "c", "lua", "luadoc", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
  matchup = {
    enable = true,              -- mandatory, false will disable the whole extension
    disable = { "c", "ruby" },  -- optional, list of language that will be disabled
    -- [options]
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}
