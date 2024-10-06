return {
	"andymass/vim-matchup",
	dependencies = {"nvim-treesitter/nvim-treesitter"},
	keys = {{"%"}},
	-- opts = {},
	config = function()
		vim.g.matchup_matchparen_offscreen = { method = "popup" }
	end,
}
