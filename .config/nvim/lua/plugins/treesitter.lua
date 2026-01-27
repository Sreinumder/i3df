return {
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "vim", "vimdoc", "c", "go", "cpp", "html", "python", "luadoc", "query",
      "markdown", "markdown_inline", "javascript", "typescript", "tsx", },
      matchup = {enable = true},
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = { enable = false },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {"html", "xml", "php", "markdown", "javascript", "javascriptreact", "typescript", "typescriptreact",},
    opts = { opts = {enable_close_on_slash = true},}
  },
  {
    "aaronik/treewalker.nvim",
    opts = {
      highlight = true, -- Whether to briefly highlight the node after jumping to it
      highlight_duration = 250, -- How long should above highlight last (in ms)
    },
    keys = {
      { mode = { "n" }, "<a-{>", "<cmd>Treewalker Left<CR>", { noremap = true } },
      { mode = { "n" }, "<a-}>", "<cmd>Treewalker Right<CR>", { noremap = true } },
      { mode = { "n" }, "<a-[>", "<cmd>Treewalker Up<CR>", { noremap = true } },
      { mode = { "n" }, "<a-]>", "<cmd>Treewalker Down<CR>", { noremap = true } },
      { mode = { "x" }, "<a-{>", "<ESC><cmd>Treewalker Left<CR>mtgv't", { noremap = true } },
      { mode = { "x" }, "<a-}>", "<ESC><cmd>Treewalker Right<CR>mtgv't>", { noremap = true } },
      { mode = { "x" }, "<a-[>", "<ESC><cmd>Treewalker Up<CR>mtgv't", { noremap = true } },
      { mode = { "x" }, "<a-]>", "<ESC><cmd>Treewalker Down<CR>mtgv't", { noremap = true } },
      { "<leader><A-[>", "<cmd>Treewalker SwapDown<cr>", { noremap = true, silent = true } },
      { "<leader><A-]>", "<cmd>Treewalker SwapUp<cr>", { noremap = true, silent = true } },
      -- { "<leader>gh", ":TSTextobjectSwapPrevious @parameter.inner<CR>", { noremap = true, silent = true } },
      -- { "<leader>gl", ":TSTextobjectSwapNext @parameter.inner<CR>", { noremap = true, silent = true } },
    },
  },
}
