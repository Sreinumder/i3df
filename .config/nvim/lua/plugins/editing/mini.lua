return {
  'nvim-mini/mini.nvim',
  version = '*',
  lazy = true,
  event = "UIEnter",
	keys = {
		{ modes = { "n", "x" }, "s", desc = "Substitute Operator" },
		{ modes = { "n", "x" }, "gm", desc = "Multiply Operator" },
		{ modes = { "n", "x" }, "<A-s>", desc = "Exchange Operator" },
		{ modes = { "n", "x" }, "g=", desc = "Evaluate Operator" },
		-- pain points solved
		{ "<A-s><A-s>", "V<A-s>", desc = "Exchange Operator line-wise", remap = true },
		{ "S", "s$", desc = "Substitute to EoL", remap = true },
		{ "gmM", "gm$", desc = "Multiply to EoL", remap = true },
		{ "<A-S>", "<A-s>$", desc = "Exchange to EoL", remap = true },
		{ "<leader>gh", "<A-s>ia<A-s>ila", desc = "Exchange arg", remap = true },
		{ "<leader>gl", "<A-s>ia<A-s>ina", desc = "Exchange arg", remap = true },
    {"<A-S-e>", "<cmd>bnext<CR>", desc = "next buffer"},
    {"<A-S-q>", "<cmd>bprevious<CR>", desc = "previous buffer"},
    {"<A-w>", "<cmd>bdelete<CR>", desc = "previous buffer"},
	},
  config = function()
    require('mini.statusline').setup({})
    require('mini.tabline').setup({
      format = function(buf_id, label)
        local suffix = vim.bo[buf_id].modified and '+ ' or ''
        -- local normal_hl = vim.api.nvim_get_hl(0, { name = 'Normal' })
        -- local is_dark = vim.o.background == 'dark'
        -- local current_bg = is_dark and '#4F7942' or '#A8E6A3'
        -- local visible_bg = is_dark and '#4f5258' or '#9b9ea4'
        -- local other_bg = is_dark and '#14161b' or '#e0e2ea'
        -- local normal_fg = is_dark and normal_hl.fg or '#14161b'
        -- local normali_fg = is_dark and '#14161b' or normal_hl.fg
        -- vim.api.nvim_set_hl(0, 'MiniTablineCurrent', {fg=normali_fg, bg = current_bg})
        -- vim.api.nvim_set_hl(0, 'MiniTablineModifiedCurrent', {fg=normali_fg, bg = current_bg, italic = true})
        -- vim.api.nvim_set_hl(0, 'MiniTablineModifiedVisible', {bg = visible_bg, italic = true})
        -- vim.api.nvim_set_hl(0, 'MiniTablineModifiedHidden', { bg = other_bg, italic = true})
        -- vim.api.nvim_set_hl(0, 'MiniTablineHidden', { bg = other_bg})
        -- vim.api.nvim_set_hl(0, 'MiniTablineTrunc', {  bg = other_bg})
        -- vim.api.nvim_set_hl(0, 'MiniTablineFill', {  bg = other_bg})
        return require('mini.tabline').default_format(buf_id, label) .. suffix
      end
    })
    require('mini.git').setup({})
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
  require("mini.trailspace").setup({})
  require("mini.pairs").setup({})
  require("mini.move").setup({})
  require("mini.align").setup({})
  require("mini.bracketed").setup({})
  require("mini.splitjoin").setup({ mappings = { toggle = '<A-m>'}, })
  require("mini.operators").setup({
    replace = { prefix = "s" },
    multiply = { prefix = "gm" },
    exchange = { prefix = "<A-s>" },
    evaluate = { prefix = "g=" },
    sort = { prefix = "" },
  })
  require("mini.surround").setup({
    custom_surroundings ={ ['<CR>'] = { output = { left = '\n ', right = ' \n' } }, },
    highlight_duration = vim.g.change_hl_duration,
    mappings = {
      add = "gs", -- Add surrounding in Normal and Visual modes
      delete = "ds", -- Delete surrounding
      replace = "cs", -- Change surrounding
      find = "", -- Find surrounding next
      find_left = "", -- Find surrounding last
      highlight = "", -- Highlight surrounding
      suffix_last = "l", -- Suffix to search with "prev" method
      suffix_next = "n", -- Suffix to search with "next" method
    },
  })
  local spec_treesitter = require("mini.ai").gen_spec.treesitter
  require("mini.ai").setup({
    custom_textobjects = {
      F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
      o = spec_treesitter({
        a = { "@conditional.outer", "@loop.outer" },
        i = { "@conditional.inner", "@loop.inner" },
      }),
      C = spec_treesitter({ a = "@call.outer", i = "@call.inner" }),
      u = { "%f[%d]%d+" }, -- number
      x = {"[%w_]+"},
    },
    mappings = {
      around_next = "an",
      inside_next = "in",
      around_last = "al",
      inside_last = "il",
      goto_left = "g[",
      goto_right = "g]",
    },
    n_lines = 200,
  }
)
end,
}
