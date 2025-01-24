return {
	"MeanderingProgrammer/render-markdown.nvim",
	-- ft = {"markdown"},
	keys = {
		{ "<leader>,mm", "<cmd>RenderMarkdown toggle<CR>", { desc = "toggle markview" } },
		{ "<leader>,mh", "<cmd>RenderMarkdown contract<CR>", { desc = "contract markview" } },
		{ "<leader>,ml", "<cmd>RenderMarkdown expand<CR>", { desc = "expand markview" } },
	},
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
	opts = {},
}
