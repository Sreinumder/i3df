return {
	"folke/which-key.nvim",
  event = "InsertEnter",
  keys = {
    { "<leader>,wk", function()
      local wk = require("which-key")
      if wk.is_open then
        wk.is_open = false -- Close the which-key window
        vim.cmd("silent! WhichKey!")
      else
        wk.is_open = true -- Open the which-key window
        vim.cmd("WhichKey")
      end
    end, { noremap = true}},
  },
  -- event = "UIEnter",
  cmd = "WhichKey",
  opts = {},
}
