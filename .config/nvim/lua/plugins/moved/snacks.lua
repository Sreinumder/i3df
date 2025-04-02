return {
  "folke/snacks.nvim",
  enabled = false,
  lazy = false,
  opts = {
	  quickfile = { enabled = true },
    picker = { enabled = true },
    gitbrowse = { enabled = true },
  },
  keys = {
    { "<leader>go", function() Snacks.gitbrowse() end, desc = "open gitbrowse", mode = { "n", "x"}},
    { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
  },
}
