return {
  "nvim-tree/nvim-tree.lua",
  keys = {
    { "<A-z>" , "<cmd>NvimTreeToggle<CR>", {desc = "toggle nvimTree"}}
  },
  opts = {
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      number = true,
      relativenumber = true,
      side = "right",
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  }
}
