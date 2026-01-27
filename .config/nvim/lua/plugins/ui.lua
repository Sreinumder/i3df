return {
  {
    'nvim-mini/mini.nvim',
    version = '*',
    lazy = true,
    event = "UIEnter",
    keys = {
      {"<C-PageDown>", "<cmd>bnext<CR>", desc = "next buffer"},
      {"<C-PageUp>", "<cmd>bprevious<CR>", desc = "previous buffer"},
      {"<A-w>", "<cmd>bdelete<CR>", desc = "close buffer"},
    },
    config = function()
      -- local function get_macro_recording_status()
        --   if vim.fn.reg_recording() ~= "" then
        --     return vim.fn.reg_recording()
        --   else
        --     return "-"
        --   end
        -- end
        require('mini.git').setup({})
        require('mini.statusline').setup({
          content = {
            active =   function()
              local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
              local git           = MiniStatusline.section_git({ trunc_width = 40 })
              local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
              local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
              local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
              local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
              local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
              local location      = MiniStatusline.section_location({ trunc_width = 75 })
              local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })
              -- local macro         = get_macro_recording_status()

              return MiniStatusline.combine_groups({
                -- { hl = 'MiniStatuslineFilename',                  strings = { macro } },
                { hl = 'MiniStatuslineFilename', strings = { filename } },
                '%<', -- Mark general truncate point
                { hl = 'MiniStatuslineFilename',  strings = { git } },
                '%=', -- End left alignment
                { hl = 'MiniStatuslineFilename',  strings = {diff, diagnostics, lsp } },
                -- { hl = 'MiniStatuslineFilename', strings = { fileinfo } },
                { hl = 'MiniStatuslineFilename',                  strings = { location } },
              })
            end,
            inactive = nil,
          },
        })
        require('mini.tabline').setup({
          format = function(buf_id, label)
            local suffix = vim.bo[buf_id].modified and '+ ' or ''
            local normal_hl = vim.api.nvim_get_hl(0, { name = 'Normal' })
            local is_dark = vim.o.background == 'dark'
            local current = is_dark and '#4F7942' or '#A8E6A3'
            local visible = is_dark and '#4f5258' or '#9b9ea4'
            local other_bg = is_dark and '#14161b' or '#e0e2ea'
            local normal_fg = is_dark and normal_hl.fg or '#14161b'
            vim.api.nvim_set_hl(0, 'MiniTablineFill', {  bg = "#000000"})
            vim.api.nvim_set_hl(0, 'MiniTablineCurrent', {fg="#4A90D9", bg = "#000000", italic = true, bold = true })
            vim.api.nvim_set_hl(0, 'MiniTablineModifiedCurrent', {fg="#4A90D9",  bg = "#000000", italic = true, bold = true })
            vim.api.nvim_set_hl(0, 'MiniTablineModifiedVisible', {  bg = "#000000", italic = true})
            vim.api.nvim_set_hl(0, 'MiniTablineVisible', {  bg = "#000000", italic = true})
            vim.api.nvim_set_hl(0, 'MiniTablineFill', {  bg = "#000000"})
            vim.api.nvim_set_hl(0, 'MiniTablineHidden', {  bg = "#000000"})
            vim.api.nvim_set_hl(0, 'MiniTablineTrunc', {  bg = "#000000"})
            vim.api.nvim_set_hl(0, 'MiniTablineModifiedHidden', {  bg = "#000000"})
            return require('mini.tabline').default_format(buf_id, label) .. suffix
          end
        })
        require('mini.cursorword').setup({})
        require('mini.hipatterns').setup({
          highlighters = {
            fixme = { pattern = 'FIXME', group = 'MiniHipatternsFixme' },
            hack  = { pattern = 'HACK',  group = 'MiniHipatternsHack'  },
            todo  = { pattern = 'TODO',  group = 'MiniHipatternsTodo'  },
            note  = { pattern = 'NOTE',  group = 'MiniHipatternsNote'  },
            hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
            trailspace = { pattern = '%f[%s]%s*$', group = 'Error' },
            censor = { pattern = 'password: ()%S+()', group = '',
            extmark_opts = censor_extmark_opts,
          },
        }
      })
      local miniclue = require('mini.clue')
      require("mini.clue").setup({
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },
          { mode = 'n', keys = ';' },
          { mode = 'x', keys = ';' },
          { mode = 'n', keys = 'go' },
          { mode = 'x', keys = 'go' },
          { mode = 'o', keys = 'i' },
          { mode = 'o', keys = 'a' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
      })
      require('mini.diff').setup({
        view = { style = 'number' },
        mappings = {
          apply = ';a',
          reset = ';r',
          textobject = 'gh',
        },
      })
    end,
  },
  {
    "xiyaowong/transparent.nvim",
    lazy=false,
    keys = { {";j", "<cmd>TransparentToggle<CR>", desc = "toggle transparency"} },
    -- dependencies = { 'projekt0n/github-nvim-theme', name = 'github-theme'},
    dependencies = {'Mofiqul/vscode.nvim'},
    opts = function()
	    vim.api.nvim_set_option_value("background", "dark", {})
	    vim.cmd('colorscheme vscode')
	    return {
		    groups = {
			    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
			    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
			    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
			    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
			    'EndOfBuffer', 'MiniFilesNormal', 'MiniFilesTitleFocused', 'MiniFilesFile',
			    'MiniStatuslineFilename', 'MiniStatuslineinfo', 'MiniStatuslineInactive', 'MiniClueDescSingle',
          'LazyNormal', 'BlinkCmpMenu'
			    -- 'MiniTablineCurrent', 'MiniTablineVisible', 'MiniTablineHidden', 'MiniTablineModifiedCurrent',
			    -- 'MiniTablineModifiedVisible', 'MiniTablineModifiedHidden',
			    -- 'StatusLine',
			    -- 'MiniTablineFill', 'MiniTablineTabpagesection', 'MiniTablineTrunc',
		    },
	    }
    end
  },
}
