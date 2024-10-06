return {
  "echasnovski/mini.files",
  version = "*",
  lazy = false,
  opts = {
    -- Customization of shown content
    content = {
      -- Predicate for which file system entries to show
      filter = nil,
      -- What prefix to show to the left of file system entry
      prefix = nil,
      -- In which order to show file system entries
      sort = nil,
    },

    mappings = {
      close = "<esc>",
      go_in = "]",
      go_in_plus = "}",
      go_out = "[",
      go_out_plus = "{",
      --    reset = "<BS>",
      -- reveal_cwd = "<leader>l",
      -- show_help = "g?",
      synchronize = "=",
      -- trim_left = "<",
      -- trim_right = ">",
    },

    -- General options
    options = {
      permanent_delete = false,
      use_as_default_explorer = true,
    },

    -- Customization of explorer windows
    windows = {
      max_number = math.huge,
      preview = true,
      width_focus = 50,
      width_nofocus = 15,
      width_preview = 35,
    },
  },
  config = function() --[[ works on only nightly ]]
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesWindowUpdate',
      callback = function(args) vim.wo[args.data.win_id].relativenumber = true end,
    })
    vim.keymap.set("n", "<leader><leader>e",
      function()
        if not require("mini.files").close() then require("mini.files").open() end
      end, {desc = "mini files"})
  end,
}
