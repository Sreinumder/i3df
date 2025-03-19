return {
  "SunnyTamang/select-undo.nvim",
  enabled = true,
  lazy = true,
  keys = {{mode = {"x"}, "gu", "<cmd>SelectUndo<CR>", desc = "select-undo"}},
  opts = { mapping = 'gu' } -- Set to false to disable mapping
}
