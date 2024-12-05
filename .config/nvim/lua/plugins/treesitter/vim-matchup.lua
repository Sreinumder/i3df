return {
	"andymass/vim-matchup",
	dependencies = {"nvim-treesitter/nvim-treesitter"},
  lazy = false,
  -- event = "UIEnter",
	-- keys = {{"%"}},
  config = function()
    vim.g.matchup_matchparen_offscreen = { method = "popup"}
  end,
}
