return {
  "nvim-treesitter/nvim-treesitter",
  -- event = { "BufReadPost", "BufNewFile", "UIEnter" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "vimdoc",
      "c",
      "go",
      "cpp",
      "html",
      "python",
      "luadoc",
      "query",
      "markdown",
      "markdown_inline",
    },
    matchup = {
      enable = true, -- mandatory, false will disable the whole extension
      disable = { "c", "ruby" }, -- optional, list of language that will be disabled
      -- [options]
    },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    indent = { enable = true },
  },
  -- config = function()
  --   require'nvim-treesitter.configs'.setup {
  --     incremental_selection = {
  --       enable = true,
  --       keymaps = {
  --         init_selection = "<leader>o",
  --       },
  --     },
  --   }
  -- end,
}

