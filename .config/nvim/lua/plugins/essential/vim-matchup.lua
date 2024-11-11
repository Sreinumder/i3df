return {
	"andymass/vim-matchup",
	dependencies = {"nvim-treesitter/nvim-treesitter"},
  event = "User FilePost",
	keys = {{"%"}},
	-- opts = {},
	config = function()
		vim.g.matchup_matchparen_offscreen = { method = "popup" }
	end,
}
