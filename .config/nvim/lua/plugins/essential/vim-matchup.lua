return {
	"andymass/vim-matchup",
	dependencies = {"nvim-treesitter/nvim-treesitter"},
  event = "UIEnter",
	keys = {{"%"}},
	-- opts = {},
	config = function()
		vim.g.matchup_matchparen_offscreen = { method = "popup" }
	end,
}
