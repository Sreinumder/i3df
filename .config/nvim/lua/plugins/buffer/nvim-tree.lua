return {
  "nvim-tree/nvim-tree.lua",
  keys = {
    { "<A-z>", function()
      require("nvim-tree.api").tree.toggle({ find_file = true, focus = false, })
    end, {desc = "toggle nvimTree"}}
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
