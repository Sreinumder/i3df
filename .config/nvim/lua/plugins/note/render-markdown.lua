return {
	'MeanderingProgrammer/render-markdown.nvim',
	ft = {"markdown"},
  keys = {
    {"<leader>,mm", ":RenderMarkdown toggle<CR>", {desc = "toggle markview"}},
    {"<leader>,mh", ":RenderMarkdown contract<CR>", {desc = "contract markview"}},
    {"<leader>,ml", ":RenderMarkdown expand<CR>", {desc = "expand markview"}},
  },
	dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
	opts = {},
}
