return {
  "echasnovski/mini.ai",
  version = "*",
  keys = {
    { "i", mode = { "n", "x", "o" } },
    { "a", mode = { "n", "x", "o" } },
  },
  opts = function()
    local spec_treesitter = require("mini.ai").gen_spec.treesitter
    local M = {
      custom_textobjects = {
        F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
        o = spec_treesitter({
          a = { "@conditional.outer", "@loop.outer" },
          i = { "@conditional.inner", "@loop.inner" },
        }),
        C = spec_treesitter({ a = "@call.outer", i = "@call.inner" }),
        -- m = spec_treesitter({ a = "@property.outer", i = "@property.inner" }),
      },
      mappings = {
        around_next = "an",
        inside_next = "in",
        around_last = "al",
        inside_last = "il",
        goto_left = "g[",
        goto_right = "g]",
      },
      n_lines = 200,
    }
    return M
  end,
}
