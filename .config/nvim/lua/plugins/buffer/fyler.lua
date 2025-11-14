return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  branch = "stable",
  opts = {
mappings = {
       ["q"] = "CloseView",
       ["<CR>"] = "Select",
       ["<C-t>"] = "SelectTab",
       ["|"] = "SelectVSplit",
       ["^"] = "SelectSplit",
       ["-"] = "GotoParent",
       ["="] = "GotoCwd",
       ["."] = "GotoNode",
       ["#"] = "CollapseAll",
       ["<BS>"] = "CollapseNode",
     },
  },
  keys = {
    {
      "<leader><leader>",
      function()
        require("fyler").toggle({
          kind = "split_right_most"
        })
      end,
      desc = "fyler" ,
    },
    {
      "+",
      function()
        require("fyler").toggle({
          -- dir = vim.api.nvim_buf_get_name(0),
          dir = vim.fn.expand('%:p:h'),
          kind = "split_right_most"
        })
      end,
      desc = "fyler" ,
    },
  },
  lazy = false
}
