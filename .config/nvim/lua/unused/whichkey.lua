return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>f", group = "arrow-file" }, -- group
      { "<leader>j", group = "arrow-line" },
      { "<leader>s", group = "search" },
      { "<leader>m", group = "split-join" },
      { "<leader>M", group = "Mason" },
      { "<leader>,", group = "toggle" },
      { "<leader>;", group = "flash jump" },
      { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
      { "<leader>,cc", desc = "toggle color value viewer" },
      -- { "<leader>fb", function() print("hello") end, desc = "Foobar" },
      -- { "<leader>fn", desc = "New File" },
      -- { "<leader>f1", hidden = true }, -- hide this keymap
      -- { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
      -- { "<leader>b", group = "buffers", expand = function()
        --   return require("which-key.extras").expand.buf()
        -- end
        -- },

        { "cr", group = "Coerce" },
        { "gcr", group = "Coerce" },
        {
          -- Nested mappings are allowed and can be added in any order
          -- Most attributes can be inherited or overridden on any level
          -- There's no limit to the depth of nesting
          mode = { "n", "v" }, -- NORMAL and VISUAL mode
          {"<A-j>", desc="mini-move up"},
          {"<A-k>", desc="mini-move down"},
          {"<A-h>", desc="mini-move left"},
          {"<A-l>", desc="mini-move right"},
          {"<A-J>", desc="Clone after"},
          {"<A-K>", desc="Clone before"},
        }
      })
    end,
  }
