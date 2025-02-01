return {
		"folke/ts-comments.nvim",
		opts = {},
		-- event = "InsertEnter",
		ft = {"typescript", "javascript", "typescriptreact", "javascriptreact", },
		enabled = vim.fn.has("nvim-0.10.0") == 1,
}
