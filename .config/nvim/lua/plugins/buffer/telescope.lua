return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {mode="n", "<leader>bb", "<cmd>Telescope buffers<CR>",                   { desc = "telescope find buffers" }},
    {mode="n", "<leader>cm", "<cmd>Telescope git_commits<CR>",               { desc = "telescope git commits" }},
    {mode="n", "<leader>ff", "<cmd>Telescope find_files<cr>",                { desc = "telescope find files" }},
    {mode="n", "<leader>fh", "<cmd>Telescope help_tags<CR>",                 { desc = "telescope help page" }},
    {mode="n", "<leader>fk", "<cmd>Telescope keymaps<cr>",                   { desc = "telescope keymaps" }},
    {mode="n", "<leader>fo", "<cmd>Telescope oldfiles<CR>",                  { desc = "telescope find oldfiles" }},
    {mode="n", "<leader>fr", "<cmd>Telescope resume<CR>",                    { desc = "telescope resume" }},
    {mode="n", "<leader>fw", "<cmd>Telescope live_grep_args<CR>",            { desc = "telescope live grep" }},
    {mode="n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" }},
    {mode="n", "<leader>gt", "<cmd>Telescope git_status<CR>",                { desc = "telescope git status" }},
    {mode="n", "<leader>ht", "<cmd>Telescope terms<CR>",                     { desc = "telescope pick hidden term" }},
    {mode="n", "<leader>ma", "<cmd>Telescope marks<CR>",                     { desc = "telescope find marks" }},
    {mode="n", "<leader>fa", 
    "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", { desc = "telescope find all files" }},
    {mode="n", "<leader>fc", function() require("nvchad.themes").open() end, { desc = "telescope nvchad themes" }},
  },
  dependencies = { "nvim-telescope/telescope-live-grep-args.nvim", },
  cmd = "Telescope",
  opts = function()
    local telescope = require("telescope")
    telescope.load_extension("live_grep_args")
    local M = {
      prompt_prefix = "   ",
      selection_caret = " ",
      entry_prefix = " ",
      sorting_strategy = "ascending",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
        },
        width = 0.87,
        height = 0.80,
      },
      mappings = {
        n = { ["q"] = require("telescope.actions").close },
      },
    }
    return M
  end,
}
