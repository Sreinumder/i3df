return {
	"nvim-treesitter/nvim-treesitter-context",
	opts = {},
	keys = {
    { "[c",
      function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end,
      { silent = true, desc = "go to context" }, },
    { "<leader>,co",
    ":TSContextToggle<cr>",
      { silent = true, desc = "go to context" }, },
	},
}
