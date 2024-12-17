return {
  "tpope/vim-dadbod",
  dependencies = {
    "kristijanhusak/vim-dadbod-completion",
    "kristijanhusak/vim-dadbod-ui",
  },
	-- event = "UIEnter",
  keys = {
    {"<A-p>", ":DBUIToggle<CR>"},
  },
  cmd = {"DBUI", "DB", "DBUIToggle"}
}
