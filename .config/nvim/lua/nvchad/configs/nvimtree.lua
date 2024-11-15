dofile(vim.g.base46_cache .. "nvimtree")

local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- OR use all default mappings
  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set("n", "L", api.tree.change_root_to_node,   opts("CD"))
  vim.keymap.set("n", "l", api.node.open.edit,             opts("Open"))
  vim.keymap.set("n", ".", api.tree.toggle_hidden_filter,  opts("Toggle Filter: Dotfiles"))
  vim.keymap.set("n", ",", api.node.run.cmd,               opts("Run    Command"))
  vim.keymap.set("n", "H", api.tree.change_root_to_parent, opts("Up"))
  vim.keymap.set("n", "D",              api.fs.remove,                      opts("Delete"))
  vim.keymap.set("n", "d",              api.fs.trash,                       opts("Trash"))
  vim.keymap.set("n", "J",              api.node.navigate.sibling.next,     opts("Next Sibling"))
  vim.keymap.set("n", "K",              api.node.navigate.sibling.prev,     opts("Previous Sibling"))
  vim.keymap.set("n", ">",              api.node.navigate.sibling.last,     opts("Last Sibling"))
  vim.keymap.set("n", "<",              api.node.navigate.sibling.first,    opts("First Sibling"))
end

return {
  on_attach = my_on_attach,
  filters = { dotfiles = false },
  disable_netrw = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    width = 30,
    preserve_window_proportions = true,
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    indent_markers = { enable = true },
    icons = {
      glyphs = {
        default = "󰈚",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
        },
        git = { unmerged = "" },
      },
    },
  },
}
