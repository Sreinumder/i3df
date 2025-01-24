return {
  "echasnovski/mini.files",
  keys = {
    { "<A-Space>", function() require('mini.files').open() end , {desc= "mini.file"}},
    { "-", function() require('mini.files').open() end , {desc= "mini.file"}},
  },
  opts = {
    content = {
      filter = nil, -- What prefix to show to the left of file system entry
      prefix = nil, -- In which order to show file system entries
      sort = nil,
    },
    prefix = function() end,
    mappings = {
      -- close       = '<Leader>wq',
      close       = '<A-Leader>',
      -- go_in       = '<A-l>',
      go_in       = '<A-l>',
      go_in_plus  = '<CR>',
      -- go_out      = '<A-h>',
      go_out      = '-',
      go_out_plus = '<A-h>',
      mark_goto   = "'",
      mark_set    = 'm',
      reset       = '<BS>',
      reveal_cwd  = '@',
      show_help   = 'g?',
      synchronize = '<leader><A-Space>',
      trim_left   = '<',
      trim_right  = '>',
    },

    -- General options
    options = { -- Whether to delete permanently or move into module-specific trash
      permanent_delete = true, -- Whether to use for editing directories
      use_as_default_explorer = true,
    },

    -- Customization of explorer windows
    windows = {
      max_number = math.huge,
      preview = true,
      width_focus = 50,
      width_nofocus = 15,
      width_preview = 25,
    },
  }
}
