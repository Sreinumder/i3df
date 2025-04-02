return {
	"folke/which-key.nvim",
  event = "UIEnter",
  cmd = "WhichKey",
  opts = {
    preset = "helix",
  },
  keys = {
    {
      "<leader>w<space>",
      function()
        require("which-key").show({ keys = "<c-w>", loop = true })
      end,
      desc = "Window Hydra Mode (which-key)",
    },
    {
      "<leader>]",
      function()
        require("which-key").show({ keys = "]", loop = true })
      end,
      desc = "] Hydra Mode (which-key)",
    },
    {
      "<leader>[",
      function()
        require("which-key").show({ keys = "[", loop = true })
      end,
      desc = "[ Hydra Mode (which-key)",
    },
  },
}
