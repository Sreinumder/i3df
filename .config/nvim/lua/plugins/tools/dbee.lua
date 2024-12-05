return {
  "kndndrj/nvim-dbee",
  dependencies = { "MunifTanjim/nui.nvim", },
  cmd = {"Dbee"},
  opts = {},
  keys  = {
    {"<leader>dbb",function() require("dbee").toggle() end, {desc="toggle dbee"}}, -- Open/close/toggle the UI.
    {"<leader>dbc",function() require("dbee").close() end, {desc="close dbee"}},
    {"<leader>dbo",function() require("dbee").open() end, {desc="open dbee"}},
  },
  build = function()
    require("dbee").install()
  end,
}
