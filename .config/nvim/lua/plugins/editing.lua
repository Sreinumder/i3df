return {
  { "gregorias/coerce.nvim",
  dependencies = { "gregorias/coop.nvim" },
  keys = { { "go", mode = { "v", "n" }, desc = "change-case" }},
  config = function()
    require("coerce").setup({
      keymap_registry = require("coerce.keymap").keymap_registry(),
      notify = function(...) return vim.notify(...) end,
      default_mode_keymap_prefixes = {
        normal_mode = "co",
        motion_mode = "go",
        visual_mode = "go",
      },
    })
  end,
},
-- { "monaqa/dial.nvim",
-- event = "InsertEnter",
-- keys = {
--   {"<leader>i"},
--   {"<leader>u"},
--   {"g<leader>i"},
--   {"g<leader>u"},
-- },
-- enabled = true,
-- config = function()
--   local augend = require("dial.augend")
--   local dial_config = require("dial.config")
--
--   local function concat_tables(table1, table2)
--     if table2 == nil then
--       return table1
--     end
--     local result = table1 or {}
--     for _, value in ipairs(table2) do
--       result = concat_tables(result, value)
--     end
--     return result
--   end
--
--   local function AGN(Elements, Word, Cyclic)
--     Word = true and Word
--     Cyclic = true and Cyclic
--     if Elements == nil then
--       return nil
--     end
--     return augend.constant.new({ elements = Elements, word = Word, cyclic = Cyclic })
--   end
--
--   local augend_base = {
--     augend.integer.alias.decimal_int, -- decimal number (-1, 0, 1, 2, 3, ...)
--     augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
--     augend.hexcolor.new({ case = "lower" }),
--     augend.hexcolor.new({ case = "upper" }),
--   }
--   dial_config.augends:register_group({
--     default = augend_base,
--     number = {
--       augend.integer.alias.decimal_int, -- decimal number (-1, 0, 1, 2, 3, ...)
--       augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
--     },
--     logical = {
--       augend.constant.alias.bool, -- boolean value (true <-> false)
--       AGN({ "True", "False" }),
--       AGN({ "and", "or" }),
--       AGN({ "&&", "||" }, false),
--       AGN({ "==", "!=" }, false),
--       AGN({ "<", ">=" }, false),
--       AGN({ ">", "<=" }, false),
--       AGN({ "+=", "-=" }, false),
--       AGN({ "*=", "/=" }, false),
--       AGN({ "++", "--" }, false),
--     },
--     word = {
--       AGN({ "yes", "no" }),
--       AGN({ "left", "right" }),
--       AGN({ "up", "down" }),
--       AGN({ "mini.cycle", "when" }),
--       AGN({ "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth" }),
--       AGN({ "First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth", "Ninth", "Tenth" }),
--     },
--     alpha = { augend.constant.alias.alpha, augend.constant.alias.Alpha }, -- a b c  A B C
--     quote = { augend.paren.alias.quote }, -- 'rose'
--     parenthesis = { augend.paren.alias.brackets },
--     date = {
--       augend.date.alias["%Y/%m/%d"], -- date (2024/04/23, etc.)
--       augend.date.alias["%d/%m/%Y"], -- date (24/04/2024, etc.)
--       augend.date.alias["%Y-%m-%d"], -- date (2024-04-23, etc.)
--       augend.date.alias["%d-%m-%Y"], -- date (24-04-2024, etc.)
--       -- augend.date.alias["%Y-%m-%d"], -- date (2024-04-23, etc.)
--       -- augend.date.alias["%d-%m-%Y"], -- date (24-04-2024, etc.)
--       augend.date.alias["%Y年%-m月%-d日(%ja)"], -- date (2024年-04月-20日, etc.)
--       augend.date.alias["%Y年%-m月%-d日"],
--       AGN({ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" }),
--       AGN({"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December",}),
--       augend.constant.alias.ja_weekday,
--       augend.constant.alias.ja_weekday_full, -- 月 金曜日
--       AGN({ "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" }),
--       AGN({ "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun" }),
--     },
--     time = {
--       augend.date.alias["%H:%M:%S"],
--       augend.date.alias["%H:%M"],
--     },
--     notes = {
--       AGN({ "- [ ]", "- [x]" }, false),
--       AGN({ "=====", "-----" }, false),
--       AGN({ "*", "**", "***", "****", "*****", "******", "*******" }, false),
--       AGN({ "# ", "## ", "### ", "#### ", "##### ", "###### " }, false),
--       -- AGN({"┘","┐","c", "└", "┌"}, false),
--       -- AGN({"e","─","│"}, false),
--       -- AGN({"◄", "h","►", "▼","▲"}, false),
--     },
--   })
--   dial_config.augends:on_filetype({
--     typescript = concat_tables(augend_base, { augend.constant.new({ elements = { "let", "const" } }) }),
--     javascript = concat_tables(augend_base, { augend.constant.new({ elements = { "let", "const" } }) }),
--     haskell = concat_tables(augend_base, {
--       augend.constant.new({ elements = { "/=", "==" }, word = false, cyclic = true }),
--     }),
--   })
--   local mode = { "n", "v" }
--   local arga = { "increment", "decrement" }
--   local argb = { "normal", "gnormal", "visual", "gvisual" }
--   local group =
--   { "default", "number", "date", "time", "word", "alpha", "logical", "parenthesis", "quote", "notes" }
--   local keymaps = {
--     { "<C-a>", "<C-x>", "g<C-a>", "g<C-x>" },
--     -- {"<leader>ii",  "<leader>uu",  "g<leader>ii",  "g<leader>uu"},-- "default
--     { "<leader>iu", "<leader>uu", "g<leader>iu", "g<leader>uu" }, -- "number"
--     { "<leader>id", "<leader>ud", "g<leader>id", "g<leader>ud" }, -- "date",
--     { "<leader>it", "<leader>ut", "g<leader>it", "g<leader>ut" }, -- "time",
--     { "<leader>iw", "<leader>uw", "g<leader>iw", "g<leader>uw" }, -- "word",
--     { "<leader>ia", "<leader>ua", "g<leader>ia", "g<leader>ua" }, -- "alpha
--     { "<leader>il", "<leader>ul", "g<leader>il", "g<leader>ul" }, -- "logical
--     { "<leader>ip", "<leader>up", "g<leader>ip", "g<leader>up" }, -- "parenthesis
--     { "<leader>iq", "<leader>uq", "g<leader>iq", "g<leader>uq" }, -- "quote",
--     { "<leader>is", "<leader>us", "g<leader>is", "g<leader>us" }, -- "notes",
--   }
--   for j = 1, #group do
--     for i = 0, 7 do
--       vim.keymap.set(mode[math.floor(i / 4) + 1], keymaps[j][i % 4 + 1], function()
--         require("dial.map").manipulate(arga[i % 2 + 1], argb[math.floor(i / 2) + 1], group[j])
--       end, {desc = group[j]})
--     end
--   end
-- end,
--   },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          enabled = true,
          autohide = false,
          jump_labels = false,
          highlight = { backdrop = false },
          keys = { "f", "F", "t", "T", [";"] = "<A-n>", [","] = "<A-p>"},
          char_actions = function(motion)
            return { -- clever-f style
              [motion:lower()] = "next",
              [motion:upper()] = "prev",
            }
          end,
        },
        search = { enabled = false, jump_labels = false}, },
        rainbow = { enabled = true, shade = 5},
      },
      keys = {
        { "f" }, { "t" },
        { "F" }, { "T" },
        {
          "<leader>;",
          mode = { "n", "x", "o" },
          function()
            require("flash").jump()
          end,
          desc = "Flash Jump",
        },
        {
          "ir",
          mode = { "x", "o" },
          function()
            require("flash").treesitter()
          end,
          desc = "Flash Treesitter",
        },
        {
          "r",
          mode = "o",
          function()
            require("flash").remote()
          end,
          desc = "Remote Flash",
        },
        {
          "<A-s>",
          mode = { "c" },
          function()
            require("flash").toggle()
          end,
          desc = "Toggle Flash Search",
        },
        {
          ";*",
          mode = { "n", "x" },
          function()
            require("flash").jump({
              pattern = vim.fn.expand("<cword>"),
            })
          end,
          desc = "current word flash"
        },
      },
      init = function()
        vim.api.nvim_set_hl(0, 'FlashLabel', {fg = '#000000', bg = '#4078f2' })
        vim.api.nvim_set_hl(0, 'FlashMatch', {fg = '#fafafa', bg = '#4078f2'})
        vim.api.nvim_set_hl(0, 'FlashCurrent', {fg = '#fafafa', bg = '#4078f2'})
        vim.api.nvim_set_hl(0, 'FlashCursor', {fg = '#fafafa', bg = '#4078f2'})
      end,
    },
    {
      "jake-stewart/multicursor.nvim",
      -- event = "CursorMoved",
      keys = {
        { mode = { "n", "v" }, "<C-A-k>", "<cmd>lua require('multicursor-nvim').lineAddCursor(-1) <CR>", desc = "Add mc above"},
        { mode = { "n", "v" }, "<C-A-j>", "<cmd>lua require('multicursor-nvim').lineAddCursor(1) <CR>", desc = "Add mc below"},
        { mode = { "n", "v" }, "<C-A-h>", "<cmd>lua require('multicursor-nvim').prevCursor()<CR>", desc = "prevCursor"},
        { mode = { "n", "v" }, "<C-A-l>", "<cmd>lua require('multicursor-nvim').nextCursor()<CR>", desc = "nextCursor"},
        { mode = { "n", "v" }, "<leader><C-A-K>", "<cmd>lua require('multicursor-nvim').lineSkipCursor(-1) <CR>", desc = "Skip cursor and above"},
        { mode = { "n", "v" }, "<leader><C-A-J>", "<cmd>lua require('multicursor-nvim').lineSkipCursor(1) <CR>", desc = "Skip cursor and below"},
        { mode = { "n", "v" }, "<C-A-3>", "<cmd>lua require('multicursor-nvim').matchAddCursor(-1) <CR>", desc = "add cursor on prev match"},
        { mode = { "n", "v" }, "<leader><C-A-3>", "<cmd>lua require('multicursor-nvim').matchSkipCursor(-1) <CR>", desc = "skip current match and next"},
        { mode = { "n", "v" }, "<C-A-8>", "<cmd>lua require('multicursor-nvim').matchAddCursor(1) <CR>", desc = "add cursor on next match"},
        { mode = { "n", "v" }, "<C-A-/>", "<cmd>lua require('multicursor-nvim').matchAllAddCursors()<CR>", desc = "Add all matches in the document"},
        { mode = { "n", "v" }, "<leader><C-A-8>", "<cmd>lua require('multicursor-nvim').matchSkipCursor(1) <CR>", desc = "skip current match and prev"},
        { mode = { "n", "v" }, "<C-A-d>", "<cmd>lua require('multicursor-nvim').deleteCursor()<CR>", desc = "Delete the main cursor."},
        { mode = "n", "<C-leftmouse>", "<cmd>lua require('multicursor-nvim').handleMouse()<CR>", desc = "Add and remove cursors with mouse"},
        { mode = "n", "<C-A-leftmouse>", "<cmd>lua require('multicursor-nvim').handleMouse(); require('multicursor-nvim').toggleCursor()<CR>", desc = "Add and remove cursors with mouse"},

        { mode = { "n", "v" }, ";s", "<cmd>lua require('multicursor-nvim').toggleCursor()<CR>", desc = "pause and add cursor"},
        { mode = { "n", "v" }, ";<A-s>", "<cmd>lua require('multicursor-nvim').duplicateCursors()<CR>", desc = "pause all mc + clone them"},
        { mode = "n", ";;",
        function()
          if not require("multicursor-nvim").cursorsEnabled() then
            require("multicursor-nvim").enableCursors()
          elseif require("multicursor-nvim").hasCursors() then
            require("multicursor-nvim").clearCursors()
          else -- Default <esc> handler.
          end
        end,
        desc = "unpause multi-cursor"
      },
      { mode = "n", ";gv", "<cmd>lua require('multicursor-nvim').restoreCursors()<CR>",  desc = "restoreCursors"},
      { mode = "n", "<leader>ga", "<cmd>lua require('multicursor-nvim').alignCursors()<CR>",  desc = "alignCursors"},
      { mode = "x", "S", function() require('multicursor-nvim').splitCursors() end,  desc = "splitCursors"},
      { mode = "x", "M", "<cmd>lua require('multicursor-nvim').matchCursors()<CR>",  desc = "matchCursors"},
      { mode = "x", "<A-9>", function() require("multicursor-nvim").transposeCursors(-1) end,  desc = "rotate cursor selection"},
      { mode = "x", "<A-0>", function() require("multicursor-nvim").transposeCursors(1) end,  desc = "rotate cursor selection"},
      { mode = "x", "I", function() require('multicursor-nvim').insertVisual() end, desc = "insertVisual"},
      { mode = "x", "A", function() require('multicursor-nvim').appendVisual() end, desc = "appendVisual"},
      { mode = { "v", "n" }, "<c-i>", "<cmd>lua require('multicursor-nvim').jumpForward()<CR>", desc = "jump backward"},
      { mode = { "v", "n" }, "<c-o>", "<cmd>lua require('multicursor-nvim').jumpBackward()<CR>", desc = "jump backward" },
    },
    opts = function()
      local hl = vim.api.nvim_set_hl
      -- hl(0, "MultiCursorCursor", { bg = "#484b3c" })
      -- hl(0, "MultiCursorVisual", { bg = "#38453c" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
      return {}
    end,
  },
  {
    "ecthelionvi/NeoSwap.nvim",
    opts = {},
    keys = {
      { "gh", "<cmd>NeoSwapPrev<cr>", desc = "swap alpha/num left" },
      { "gl", "<cmd>NeoSwapNext<cr>", desc = "swap alpha/num right" },
    },
  },
  {
    "echasnovski/mini.align",
    opts = {},
    keys = {
      { "ga", mode = { "n", "v" }, desc = "align" },
      { "gA", mode = { "n", "v" }, desc = "align with preview" },
    },
  },
  {
    'echasnovski/mini.move',
    keys = {
      {"<A-h>", mode={"x", "n"}},
      {"<A-j>", mode={"x", "n"}},
      {"<A-k>", mode={"x", "n"}},
      {"<A-l>", mode={"x", "n"}},
    },
    opts = {
      mappings = {
        left =  '<A-h>',
        right = '<A-l>',
        down =  '<A-j>',
        up =    '<A-k>',
        line_left = '<A-h>',
        line_right = '<A-l>',
        line_down = '<A-j>',
        line_up = '<A-k>',
      },
    }
  },
  {
    "echasnovski/mini.operators",
    dependencies = { "echasnovski/mini.ai" },
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
    },
    opts = {
      replace = { prefix = "s" },
      multiply = { prefix = "gm" },
      exchange = { prefix = "<A-s>" },
      evaluate = { prefix = "g=" },
      sort = { prefix = "" },
    },
  },
  {
    "echasnovski/mini.surround",
    keys = {
      { "gs", mode={ "n", "x" } },
      { "ds", mode={ "n", "x" } },
      { "cs", mode={ "n", "x" } },
    },
    opts = {
      custom_surroundings ={ ['<CR>'] = { output = { left = '\r ', right = ' \r' } }},
      respect_selection_type  = true,
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
    }
  },
  {
    'echasnovski/mini.pairs',
    enabled = false,
    event = "InsertEnter",
    opts = {},
  },
  {
    "echasnovski/mini.splitjoin",
    opts = { mappings = { toggle = '<A-m>'}, }
  },
  {
    "echasnovski/mini.pairs",
    opts = {}
  },
  {
    "echasnovski/mini.ai",
    version = "*",
    keys = {
      { "i", mode = { "n", "x", "o" } },
      { "a", mode = { "n", "x", "o" } },
    },
    opts = function()
      local spec_treesitter = require("mini.ai").gen_spec.treesitter
      return {
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
    end,
  },
  {
    "echasnovski/mini.bracketed",
    keys = { "[", "]" },
    opts = {},
  },
  {
    "echasnovski/mini.splitjoin",
    keys = {{'<A-m>', desc = "split-join"}},
    opts = { mappings = { toggle = '<A-m>'}, }
  },
  { 
    "echasnovski/mini.trailspace",
    keys = {
      { modes = { "n", "x" }, "<leader>dtt", "<cmd>lua MiniTrailspace.trim_last_lines()<CR>" ,desc = "delete_traillines" },
      { modes = { "n", "x" }, "<leader>dte", "<cmd>lua MiniTrailspace.trim()<CR>" ,desc = "delete_trailspace" },
    }
  },
  {
    'jbyuki/venn.nvim',
    -- opts = {},
    lazy = false,
    config = function()
      function _G.Toggle_venn()
        local venn_enabled = vim.inspect(vim.b.venn_enabled)
        if venn_enabled == "nil" then
          vim.b.venn_enabled = true
          vim.cmd[[setlocal ve=all]]
          -- draw a line on HJKL keystokes
          vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
          vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
          vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
          vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
          -- draw a box by pressing "f" with visual selection
          vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
          vim.api.nvim_buf_set_keymap(0, "v", "F", ":VBoxD<CR>", {noremap = true})
        else
          vim.cmd[[setlocal ve=]]
          vim.api.nvim_buf_del_keymap(0, "n", "J")
          vim.api.nvim_buf_del_keymap(0, "n", "K")
          vim.api.nvim_buf_del_keymap(0, "n", "L")
          vim.api.nvim_buf_del_keymap(0, "n", "H")
          vim.api.nvim_buf_del_keymap(0, "v", "f")
          vim.b.venn_enabled = nil
        end
      end

      vim.api.nvim_set_keymap('n', ';v', ":lua Toggle_venn()<CR>", { noremap = true})
    end,
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    keys = function()
      local function delete_indentation() -- dsi
        require("various-textobjs").indentation("outer", "outer")
        local indentationFound = vim.fn.mode():find("V")
        if not indentationFound then
          return
        end
        vim.cmd.normal({ "<", bang = true }) -- dedent indentation
        local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1] -- delete surrounding lines
        local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1]
        vim.cmd(tostring(endBorderLn) .. " delete") -- delete first so line index is not shifted
        vim.cmd(tostring(startBorderLn) .. " delete")
      end

      local function yank_surrounding() --ysi
        local startPos = vim.api.nvim_win_get_cursor(0)
        require("various-textobjs").indentation("outer", "outer")
        local indentationFound = vim.fn.mode():find("V")
        if not indentationFound then
          return
        end
        vim.cmd.normal({ "V", bang = true }) -- leave visual mode so the '< '> marks are set
        local startLn = vim.api.nvim_buf_get_mark(0, "<")[1] - 1
        local endLn = vim.api.nvim_buf_get_mark(0, ">")[1] - 1
        local startLine = vim.api.nvim_buf_get_lines(0, startLn, startLn + 1, false)[1]
        local endLine = vim.api.nvim_buf_get_lines(0, endLn, endLn + 1, false)[1]
        vim.fn.setreg('"', startLine .. "\n" .. endLine .. "\n") -- highlight yanked text
        local ns = vim.api.nvim_create_namespace("ysi")
        vim.api.nvim_buf_add_highlight(0, ns, "IncSearch", startLn, 0, -1)
        vim.api.nvim_buf_add_highlight(0, ns, "IncSearch", endLn, 0, -1)
        vim.defer_fn(function()
          vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
        end, 1000)
        vim.api.nvim_win_set_cursor(0, startPos)
      end

      return {
        { mode = { "o", "x" }, "g;", '<cmd>lua require("various-textobjs").lastChange()<CR>' },
        { mode = { "o", "x" }, "ih", '<cmd>lua require("various-textobjs").lineCharacterwise("inner")<CR>' },
        -- { mode = { "o", "x" }, "ah", '<cmd>lua require("various-textobjs").lineCharacterwise("outer")<CR>' },
        -- { mode = { "o", "x" }, "iu", '<cmd>lua require("various-textobjs").number("inner")<CR>' },
        { mode = { "o", "x" }, "m", '<cmd>lua require("various-textobjs").chainMember("outer")<CR>' },
        { mode = { "o", "x" }, "ij", '<cmd>lua require("various-textobjs").column()<CR>' },
        { mode = { "o", "x" }, "iR", '<cmd>lua require("various-textobjs").restOfIndentation()<CR>' },
        {
          mode = { "o", "x" },
          "ii",
          "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>",
          desc = "inner-inner indentation textobj",
        },
        {
          mode = { "o", "x" },
          "ai",
          function()
            local ft = vim.bo.filetype -- Get the current buffer's filetype
            if ft == "python" or ft == "python2" then
              require("various-textobjs").indentation("outer", "inner")
            else
              require("various-textobjs").indentation("outer", "outer")
            end
          end,
          desc = "outer-inner indentation textobj",
        },
        { "dsi", delete_indentation, desc = "Delete Surrounding Indentation" },
        { "ysi", yank_surrounding, desc = "Yank surrounding indentation" },
        { mode = { "o", "x" }, "is", '<cmd>lua require("various-textobjs").subword("inner")<CR>' },
        { mode = { "o", "x" }, "gx", '<cmd>lua require("various-textobjs").url()<CR>' },
      }
    end,
  },
  -- {
  --   'andymass/vim-matchup',
  --   lazy = false,
  --   init = function()
  --     vim.g.matchup_treesitter_stopline = 500
  --   end,
  --   opts = {treesitter = {stopline = 500}}
  -- }
}
