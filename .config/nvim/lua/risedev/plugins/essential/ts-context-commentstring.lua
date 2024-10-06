-- sets different types of commentstring for css html js inside the same file with the power of treesitter
return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	opts = {
		enable_autocmd = false,
	},
	ft = { "html", "css", "js", "html5", "svelte" },
	config = function()
		require("ts_context_commentstring").setup({
			enable_autocmd = false,
		})
	end,
}
