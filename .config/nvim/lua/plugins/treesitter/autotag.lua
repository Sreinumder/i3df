-- ┌────────────────────────────────────────────┐
-- │automatically sets html tags like <t1> </t1>│
-- └────────────────────────────────────────────┘
return {
  "windwp/nvim-ts-autotag",
  ft = {
    "html",
    "xml",
    "php",
    "markdown",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  opts = {
    opts = {
      enable_close = true, -- Auto close tags
      enable_rename = true, -- Auto rename pairs of tags
      enable_close_on_slash = true -- Auto close on trailing </
    },
    per_filetype = {
      ["html"] = {
        enable_close = true
      }
    }
  }
}
