vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.netrw_browser_split = 4
vim.g.netrw_banner = 0

vim.pack.add({'https://github.com/nvim-mini/mini.nvim', 'https://github.com/folke/flash.nvim',
              'https://github.com/chrisgrieser/nvim-various-textobjs',
              'https://github.com/jake-stewart/multicursor.nvim',
              'https://github.com/gregorias/coop.nvim' ,
              'https://github.com/gregorias/coerce.nvim'
            })
require("coerce").setup({
  -- camelCase 	  _c
  -- dot.case 	  _d
  -- kebab-case 	_k
  -- n12e 	      _n
  -- PascalCase 	_p
  -- snake_case 	_s
  -- UPPER_CASE 	_u
  -- path/case 	  _/
  -- space case 	_<space>
  default_mode_keymap_prefixes = {motion_mode = "_", visual_mode = "_",},
})

require('mini.operators').setup({
    replace = {
        prefix = "s"
    },
    evaluate = {
        prefix = "g="
    },
    exchange = {
        prefix = "<A-s>"
    },
    multiply = {
        prefix = "gm"
    },
    sort = {
        prefix = "gS"
    }
})

require("various-textobjs").setup()
require('mini.surround').setup({
    respect_selection_type = true,
    mappings = {
        add = "gs", -- Add surrounding in Normal and Visual modes
        delete = "ds", -- Delete surrounding
        replace = "cs", -- Change surrounding
        find = "", -- Find surrounding next
        find_left = "", -- Find surrounding last
        highlight = "" -- Highlight surrounding
    }
})

require('mini.move').setup()

vim.keymap.set({"o", "x"}, "g;", '<cmd>lua require("various-textobjs").lastChange()<CR>')
vim.keymap.set({"o", "x"}, "ih", '<cmd>lua require("various-textobjs").lineCharacterwise("inner")<CR>')
vim.keymap.set({"o", "x"}, "iu", '<cmd>lua require("various-textobjs").number("inner")<CR>')
vim.keymap.set({"o", "x"}, "m", '<cmd>lua require("various-textobjs").chainMember("outer")<CR>')
vim.keymap.set({"o", "x"}, "ij", '<cmd>lua require("various-textobjs").column()<CR>')
vim.keymap.set({"o", "x"}, "ir", '<cmd>lua require("various-textobjs").restOfIndentation()<CR>')
vim.keymap.set({"o", "x"}, "ii", "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>", {
    desc = "inner-inner indentation textobj"
})
vim.keymap.set({"o", "x"}, "ai", function()
    local ft = vim.bo.filetype
    if ft == "python" or ft == "python2" then
        require("various-textobjs").indentation("outer", "inner")
    else
        require("various-textobjs").indentation("outer", "outer")
    end
end, {
    desc = "outer-inner indentation textobj"
})
vim.keymap.set("n", "dsi", function()
    require("various-textobjs").indentation("outer", "outer")
    local indentationFound = vim.fn.mode():find("V")
    if not indentationFound then
        return
    end
    vim.cmd.normal({
        "<",
        bang = true
    }) -- dedent indentation
    local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1] -- delete surrounding lines
    local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1]
    vim.cmd(tostring(endBorderLn) .. " delete") -- delete first so line index is not shifted
    vim.cmd(tostring(startBorderLn) .. " delete")
end, {
    desc = "Delete Surrounding Indentation"
})
vim.keymap.set("n", "ysi", function()
    local startPos = vim.api.nvim_win_get_cursor(0)
    require("various-textobjs").indentation("outer", "outer")
    local indentationFound = vim.fn.mode():find("V")
    if not indentationFound then
        return
    end
    vim.cmd.normal({
        "V",
        bang = true
    }) -- leave visual mode so the '< '> marks are set
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
end, {
    desc = "Yank surrounding indentation"
})
vim.keymap.set({"o", "x"}, "is", '<cmd>lua require("various-textobjs").subword("inner")<CR>')
vim.keymap.set({"o", "x"}, "gx", '<cmd>lua require("various-textobjs").url()<CR>')

local mc = require('multicursor-nvim');
mc.setup()
vim.keymap.set({"n", "x"}, "<C-A-k>", function()
    mc.lineAddCursor(-1)
end)
vim.keymap.set({"n", "x"}, "<C-A-j>", function()
    mc.lineAddCursor(1)
end)
vim.keymap.set({"n", "x"}, "<leader><C-A-k>", function()
    mc.lineSkipCursor(-1)
end)
vim.keymap.set({"n", "x"}, "<leader><C-A-j>", function()
    mc.lineSkipCursor(1)
end)
vim.keymap.set({"n", "x"}, "<C-A-n>", function()
    mc.matchAddCursor(1)
end)
vim.keymap.set({"n", "x"}, "<C-A-s>", function()
    mc.matchSkipCursor(1)
end)
vim.keymap.set({"n", "x"}, "<C-A-S-N>", function()
    mc.matchAddCursor(-1)
end)
vim.keymap.set({"n", "x"}, "<C-A-S-s>", function()
    mc.matchSkipCursor(-1)
end)
vim.keymap.set("n", "<c-a-leftmouse>", mc.handleMouse)
vim.keymap.set("n", "<c-a-leftdrag>", mc.handleMouseDrag)
vim.keymap.set("n", "<c-a-leftrelease>", mc.handleMouseRelease)
vim.keymap.set({"n", "x"}, "<c-q>", mc.toggleCursor)
vim.keymap.set({"n", "x"}, "<leader><c-q>", mc.duplicateCursors)
vim.keymap.set("n", "<leader>a", mc.alignCursors)
vim.keymap.set({"n", "x"}, "ga", mc.addCursorOperator)
vim.keymap.set("x", "S", mc.splitCursors)
vim.keymap.set("x", "M", mc.matchCursors)
vim.keymap.set("n", "<leader>v", mc.restoreCursors)
vim.keymap.set({"n", "x"}, "<leader>A", mc.matchAllAddCursors)
vim.keymap.set("x", "<leader>t", function()
    mc.transposeCursors(1)
end)
vim.keymap.set("x", "<leader>T", function()
    mc.transposeCursors(-1)
end)
vim.keymap.set("x", "I", mc.insertVisual)
vim.keymap.set("x", "A", mc.appendVisual)
vim.keymap.set("n", "<leader>n", function()
    mc.searchAddCursor(1)
end)
vim.keymap.set("n", "<leader>N", function()
    mc.searchAddCursor(-1)
end)
vim.keymap.set("n", "<leader>s", function()
    mc.searchSkipCursor(1)
end)
vim.keymap.set("n", "<leader>S", function()
    mc.searchSkipCursor(-1)
end)
vim.keymap.set("n", "<leader>//", mc.searchAllAddCursors)
mc.addKeymapLayer(function(layerSet)
    -- Select a different cursor as the main one.
    layerSet({"n", "x"}, "<C-A-h>", mc.prevCursor)
    layerSet({"n", "x"}, "<C-A-l>", mc.nextCursor)

    -- Delete the main cursor.
    layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)

    -- Enable and clear cursors using escape.
    layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
            mc.enableCursors()
        else
            mc.clearCursors()
        end
    end)
end)

vim.keymap.set("n", "<A-s><A-s>", "V<A-s>", {
    desc = "Exchange Operator line-wise",
    remap = true
})
vim.keymap.set("n", "S", "s$", {
    desc = "Substitute to EoL",
    remap = true
})
vim.keymap.set("n", "gmM", "gm$", {
    desc = "Multiply to EoL",
    remap = true
})
vim.keymap.set("n", "<A-S>", "<A-s>$", {
    desc = "Exchange to EoL",
    remap = true
})
vim.keymap.set("n", "<leader>gh", "<A-s>ia<A-s>ila", {
    desc = "Exchange arg",
    remap = true
})
vim.keymap.set("n", "<leader>gl", "<A-s>ia<A-s>ina", {
    desc = "Exchange arg",
    remap = true
})

local neoswap_entity_pattern = {
    w = {
        _in = "\\w",
        out = "\\W",
        prev_end = "\\zs\\w\\W\\+$"
    },
    k = {
        _in = "\\k",
        out = "\\k\\@!",
        prev_end = "\\k\\(\\k\\@!.\\)\\+$"
    }
}

local function neoswap_swap_prev(cursor_pos, entity_type)
    entity_type = entity_type or "w"
    cursor_pos = cursor_pos or "follow"

    local line = vim.api.nvim_get_current_line()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local c = cursor[2]
    local line_before_cursor = line:sub(1, c + 1)

    local pattern = neoswap_entity_pattern[entity_type]
    if not pattern then
        return
    end
    local _in = pattern._in
    local out = pattern.out
    local prev_end = pattern.prev_end

    local current_word_start = vim.fn.match(line_before_cursor, _in .. "\\+$")
    if current_word_start == -1 then
        return
    end

    local current_word_end = vim.fn.match(line, _in .. out, current_word_start)
    current_word_end = current_word_end == -1 and #line - 1 or current_word_end

    local prev_word_end = vim.fn.match(line:sub(1, current_word_start), prev_end)
    if prev_word_end == -1 then
        return
    end
    local prev_word_start = vim.fn.match(line:sub(1, prev_word_end + 1), _in .. "\\+$")

    local current_word = line:sub(current_word_start + 1, current_word_end + 1)
    local prev_word = line:sub(prev_word_start + 1, prev_word_end + 1)

    local new_line = (prev_word_start > 0 and line:sub(1, prev_word_start) or "") .. current_word ..
                         line:sub(prev_word_end + 2, current_word_start) .. prev_word .. line:sub(current_word_end + 2)

    local new_c = c
    if cursor_pos == "keep" then
        new_c = c + 1
    elseif cursor_pos == "follow" then
        new_c = c + prev_word_start - current_word_start + 1
    elseif cursor_pos == "left" then
        new_c = prev_word_start + 1
    end

    vim.api.nvim_set_current_line(new_line)
    vim.api.nvim_win_set_cursor(0, {cursor[1], math.max(0, new_c - 1)})
end

local function neoswap_swap_next(cursor_pos, entity_type)
    entity_type = entity_type or "w"
    cursor_pos = cursor_pos or "follow"

    local line = vim.api.nvim_get_current_line()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local c = cursor[2]
    local line_before_cursor = line:sub(1, c + 1)

    local pattern = neoswap_entity_pattern[entity_type]
    if not pattern then
        return
    end
    local _in = pattern._in
    local out = pattern.out

    local current_word_start = vim.fn.match(line_before_cursor, _in .. "\\+$")
    if current_word_start == -1 then
        return
    end

    local current_word_end = vim.fn.match(line, _in .. out, current_word_start)
    current_word_end = current_word_end == -1 and #line - 1 or current_word_end

    local next_word_start = vim.fn.match(line, _in, current_word_end + 1)
    if next_word_start == -1 then
        return
    end

    local next_word_end = vim.fn.match(line, _in .. out, next_word_start)
    next_word_end = next_word_end == -1 and #line - 1 or next_word_end

    local current_word = line:sub(current_word_start + 1, current_word_end + 1)
    local next_word = line:sub(next_word_start + 1, next_word_end + 1)

    local new_line = (current_word_start > 0 and line:sub(1, current_word_start) or "") .. next_word ..
                         line:sub(current_word_end + 2, next_word_start) .. current_word .. line:sub(next_word_end + 2)

    local new_c = c
    if cursor_pos == "keep" then
        new_c = c + 1
    elseif cursor_pos == "follow" then
        new_c = c + next_word:len() + next_word_start - current_word_end
    elseif cursor_pos == "left" then
        new_c = current_word_start + 1
    end

    vim.api.nvim_set_current_line(new_line)
    vim.api.nvim_win_set_cursor(0, {cursor[1], math.max(0, new_c - 1)})
end

vim.keymap.set("n", "gh", function()
    neoswap_swap_prev("follow", "w")
end, {
    desc = "Swap word left"
})

vim.keymap.set("n", "gl", function()
    neoswap_swap_next("follow", "w")
end, {
    desc = "Swap word right"
})

require('mini.pairs').setup()
require('mini.splitjoin').setup({
    mappings = {
        toggle = '<A-m>'
    }
})
require('mini.ai').setup()
require('mini.bracketed').setup()
vim.api.nvim_set_hl(0, 'FlashLabel', {
    fg = '#fdfdfd',
    bg = "#d16a6a"
})
vim.api.nvim_set_hl(0, 'FlashMatch', {
    fg = '#fdfdfd',
    bg = '#4078f2'
})
vim.api.nvim_set_hl(0, 'FlashCurrent', {
    fg = '#fdfdfd',
    bg = '#4078f2'
})
vim.api.nvim_set_hl(0, 'FlashCursor', {
    fg = '#fdfdfd',
    bg = '#4078f2'
})
require('flash').setup({
    modes = {
        char = {
            enabled = true,
            autohide = false,
            jump_labels = false,
            highlight = {
                backdrop = false
            },
            keys = {
                "f",
                "F",
                "t",
                "T",
                [";"] = "<A-n>",
                [","] = "<A-p>"
            },
            char_actions = function(motion)
                return {
                    [motion:lower()] = "next",
                    [motion:upper()] = "prev"
                }
            end
        },
        search = {
            enabled = false,
            jump_labels = false
        }
    },
    rainbow = {
        enabled = true,
        shade = 5
    }
})
vim.keymap.set("n", "<leader><leader>", function()
    require('flash').jump()
end, {
    desc = "Flash Jump"
})

-- require('nvim-various-textobjs').setup()

vim.o.undofile = true
vim.o.ignorecase = true
vim.o.undolevels = 10000
vim.o.virtualedit = "block"
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.filetype.add({
    extension = {
        kbd = "kbd",
        conf = "conf"
    }
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "conf",
    callback = function()
        vim.opt_local.commentstring = "# %s"
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "kbd",
    callback = function()
        vim.opt_local.commentstring = ";; %s"
    end
})

vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-l><CR>", {
    desc = "Redraw / Clear hlsearch / Diff Update"
})
vim.keymap.set("x", "J", "j", {
    desc = "Disable annoying J "
})
vim.keymap.set("n", "<leader>gv", "printf('`[%s`]', getregtype()[0])", {
    expr = true,
    desc = "reselect last paste"
})
vim.keymap.set({"n", "x"}, "j", "v:count == 0 ? 'gj' : 'j'", {
    desc = "Down",
    expr = true,
    silent = true
})
vim.keymap.set({"n", "x"}, "k", "v:count == 0 ? 'gk' : 'k'", {
    desc = "Up",
    expr = true,
    silent = true
})
vim.keymap.set({"n", "x"}, "gj", "j", {
    desc = "next line"
})
vim.keymap.set({"n", "x"}, "gk", "k", {
    desc = "prev line"
})
vim.keymap.set("n", "<leader>w", "<C-w>", {
    desc = "window control"
})
vim.keymap.set({"n", "v", "o"}, "H", "^", {
    desc = "Beg of line"
})
vim.keymap.set({"n", "v", "o"}, "L", "g_", {
    desc = "End of Line"
})
vim.keymap.set({"n", "x"}, ",", '"+', {
    desc = 'clipboard_register'
}) -- clipboard management
vim.keymap.set({"n", "x"}, "x", '"_x') -- delete with x d or D and cut with alt + x, alt + d, alt + D, alt + c
vim.keymap.set({"n", "x"}, "X", '"_X')
vim.keymap.set({"n", "x"}, "d", '"_d')
vim.keymap.set({"n", "x"}, "D", '"_D')
vim.keymap.set({"n", "x"}, "c", '"_c')
vim.keymap.set({"n", "x"}, "C", '"_C')
vim.keymap.set({"v", "x"}, "p", '"_dP')
vim.keymap.set({"v", "x"}, "P", '"_dp')
vim.keymap.set({"n", "x"}, "<A-d>", "d") -- default of d (the only cut I will really use)
vim.keymap.set({"n", "x"}, "<A-d>ap", "dap")
vim.keymap.set({"n", "x"}, "<A-d>ip", "dip")
vim.keymap.set({"n", "x"}, "<A-D>", "D")
vim.keymap.set({"n", "x"}, "<A-d><A-d>", "dd")
vim.keymap.set({"n", "x"}, ",d", '"+d')
vim.keymap.set({"n", "x"}, ",dd", '"+dd')
vim.keymap.set({"n", "x"}, ",D", '"+D')
vim.keymap.set("n", "<A-J>", 'V"cy"cP==gv<Esc>', {
    desc = "clone line Down"
}) -- clone sentences up and down
vim.keymap.set("n", "<A-K>", 'V"cy"cgp==gv<Esc>', {
    desc = "clone line Up"
})
vim.keymap.set("x", "<A-J>", '"cy"cP==gv', {
    desc = "clone selection Down"
})
vim.keymap.set("x", "<A-K>", '"cy"cgp==gv', {
    desc = "clone selection Up"
})
vim.keymap.set("x", "<leader><A-j>", '"bdo<esc>"bp==', {
    desc = "move selection Down(v) to new line"
}) -- move/clone selection to new line above or below
vim.keymap.set("x", "<leader><A-k>", '"bdO<esc>"bp==', {
    desc = "move selection Up(v) to new line"
})
vim.keymap.set("x", "<leader><A-J>", '"byo<esc>"bp==', {
    desc = "clone selection Down(v) to new line"
})
vim.keymap.set("x", "<leader><A-K>", '"byO<esc>"bp==', {
    desc = "clone selection Up(v) to new line"
})
vim.keymap.set('x', 'g/', '<Esc>/\\%V')
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", {
    silent = true,
    desc = "hack save this buffer"
})
vim.keymap.set({"n", "x"}, ",d", '"+d')
vim.keymap.set("i", ",", ",<c-g>u", {
    desc = "Insert-mode"
}) -- Add undo break-points
vim.keymap.set("i", ".", ".<c-g>u", {
    desc = "Insert-mode"
})
vim.keymap.set("i", ";", ";<c-g>u", {
    desc = "Insert-mode"
})
vim.keymap.set("c", "<C-A-K>", "\\(.*\\)", {
    desc = "Cmd-mode catching group/kirby "
})
vim.keymap.set({"n", "x"}, "<C-/>", "gcc", {
    remap = true,
    silent = true,
    desc = "comment"
})

function ToggleTodo()
    local line = vim.api.nvim_get_current_line()
    local new_line
    if line:match("^%s*-%s*%[ %]") then -- Unchecked to checked
        new_line = line:gsub("^(%s*-%s*)%[ %]", "%1[x]")
    elseif line:match("^%s*-%s*%[x%]") then -- Checked to unchecked
        new_line = line:gsub("^(%s*-%s*)%[x%]", "%1[ ]")
    else
        return
    end
    vim.api.nvim_set_current_line(new_line)
end
vim.keymap.set("n", "<leader>tt", ToggleTodo, {
    noremap = true,
    silent = true
})
vim.keymap.set("n", "<leader>to", "o- [ ] ", {
    desc = "markdown todo below"
})
vim.keymap.set("n", "<leader>tO", "O- [ ] ", {
    desc = "markdown todo below"
})
vim.keymap.set("n", "<leader>tc", "cc- [ ] ", {
    desc = "markdown todo change"
})

if vim.g.vscode then
    vim.g.neovim_log_level = 0 -- Disable logging output from Neovim
    -- vim.opt.shortmess:append("ACI")
    -- vim.o.completeopt = ""

    require('vim.treesitter.highlighter').disable = true
    vim.o.completeopt = ""
    vim.keymap.set("n", "<leader>k", function()
        require("vscode").action("workbench.action.showAllEditors")
    end, {
        desc = "tabs"
    })
    vim.keymap.set("n", ";hr", function()
        require("vscode").action("git.revertSelectedRanges")
    end, {
        desc = "reset range"
    })
    vim.keymap.set("n", ";hs", function()
        require("vscode").action("git.stageSelectedRanges")
    end, {
        desc = "stage range"
    })
    vim.keymap.set("n", ";hu", function()
        require("vscode").action("git.unstageSelectedRanges")
    end, {
        desc = "unstage range"
    })
    vim.keymap.set("n", ";hd", function()
        require("vscode").action("git.openChange")
    end, {
        desc = "buffer diff"
    })
    vim.keymap.set("n", ";ho", function()
        require("vscode").action("gitlens.openOnlyChangedFiles")
    end, {
        desc = "gitlens.openOnlyChangedFiles"
    })
    vim.keymap.set("n", "]x", function()
        require("vscode").action("editor.action.marker.nextInFiles")
    end, {
        desc = "mark next"
    })
    vim.keymap.set("n", "[x", function()
        require("vscode").action("editor.action.marker.prevInFiles")
    end, {
        desc = "mark prev"
    })

else ----------------------------------------- non vscode settings
    vim.o.autocomplete = true
    vim.o.wrap = true
    vim.cmd('colorscheme miniwinter')
    -- vim.cmd('colorscheme miniautumn')
    vim.opt.shortmess:append("sI")

    local MiniFiles = require('mini.files')
    vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesWindowUpdate",
        callback = function(args)
            local buf_id = args.data.buf_id
            vim.api.nvim_buf_set_keymap(buf_id, "n", "<A-j>", "j", {})
            vim.api.nvim_buf_set_keymap(buf_id, "n", "<A-k>", "k", {})
            vim.wo[args.data.win_id].relativenumber = true
            vim.wo[args.data.win_id].number = true
        end
    })
    vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesWindowOpen',
        callback = function(args)
            local win_id = args.data.win_id
            local config = vim.api.nvim_win_get_config(win_id)
            config.border, config.title_pos = 'single', 'center'
            vim.api.nvim_win_set_config(win_id, config)
        end
    })
    require("mini.files").setup({
        options = {
            permanent_delete = false,
            use_as_default_explorer = true
        },
        mappings = {
            close = "<ESC>",
            go_in = "<A-l>",
            go_in_plus = "<CR>",
            go_out = "-",
            go_out_plus = "<A-h>"
        }
    })
    vim.keymap.set('n', '-', function()
        if not require('mini.files').close() then
            require('mini.files').open(vim.api.nvim_buf_get_name(0))
            require('mini.files').reveal_cwd()
        end
    end, {
        desc = "opens minifiles"
    })
    vim.keymap.set('n', "<leader>e", function()
        if not require("mini.files").close() then
            require("mini.files").open()
        end
    end, {
        desc = "mini.file"
    })
    require('mini.diff').setup({
        view = {
            style = 'number'
        },
        mappings = {
            apply = ';a',
            reset = ';r',
            textobject = 'gh'
        }
    })

    require('mini.hipatterns').setup({
        highlighters = {
            fixme = {
                pattern = 'FIXME',
                group = 'MiniHipatternsFixme'
            },
            hack = {
                pattern = 'HACK',
                group = 'MiniHipatternsHack'
            },
            todo = {
                pattern = 'TODO',
                group = 'MiniHipatternsTodo'
            },
            note = {
                pattern = 'NOTE',
                group = 'MiniHipatternsNote'
            },
            hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
            trailspace = {
                pattern = '%f[%s]%s*$',
                group = 'Error'
            },
            censor = {
                pattern = 'password: ()%S+()',
                group = '',
                extmark_opts = censor_extmark_opts
            }
        }
    })

    vim.o.relativenumber = true
    vim.o.number = true
    vim.o.tabstop = 2 -- 2 spaces for tabs (prettier default)
    vim.o.shiftwidth = 2 -- 2 spaces for indent width
    vim.o.softtabstop = 2
    vim.o.expandtab = true -- expand tab to spaces
    vim.o.autoindent = true -- copy indent from current line when starting new one

    vim.pack.add({"https://github.com/nvim-treesitter/nvim-treesitter"}, {
        confirm = false
    })
    require("nvim-treesitter.install").update("all")

    -- require('mini.statusline').setup({
    --   content = {
    --     active = function()
    --       local mode, mode_hl = MiniStatusline.section_mode({trunc_width = 120})
    --       local git = MiniStatusline.section_git({trunc_width = 40})
    --       local diff = MiniStatusline.section_diff({trunc_width = 75})
    --       local diagnostics = MiniStatusline.section_diagnostics({trunc_width = 75})
    --       local lsp = MiniStatusline.section_lsp({trunc_width = 75})
    --       local filename = MiniStatusline.section_filename({trunc_width = 140})
    --       local location = MiniStatusline.section_location({trunc_width = 75})
    --       local search = MiniStatusline.section_searchcount({trunc_width = 75})
    --       return MiniStatusline.combine_groups({{hl = 'MiniStatuslineFilename', strings = {filename}}, '%<', -- Mark general truncate point
    --       {hl = 'MiniStatuslineFilename', strings = {git}}, '%=', -- End left alignment
    --       {hl = 'MiniStatuslineFilename', strings = {diff, diagnostics, lsp}},
    --       {hl = 'MiniStatuslineFilename', strings = {location}}})
    --     end,
    --     inactive = nil
    --   }
    -- })

    vim.keymap.set("n", "<C-PageDown>", "<cmd>bnext<CR>", {
        desc = "next buffer"
    })
    vim.keymap.set("n", "<C-PageUp>", "<cmd>bprevious<CR>", {
        desc = "previous buffer"
    })
    vim.keymap.set("n", "<A-w>", "<cmd>bdelete<CR>", {
        desc = "close buffer"
    })

    vim.pack.add({"https://github.com/ibhagwan/fzf-lua"})
    require('fzf-lua').setup({
        winopts = {
            row = 0.95,
            col = 0.00,
            height = 0.60,
            width = 1.00
        },
        keymap = {
            fzf = {
                ["ctrl-q"] = "select-all+accept",
                ["ctrl-d"] = "preview-page-down",
                ["ctrl-u"] = "preview-page-up",
                ["alt-a"] = "toggle-all"
            }
        }
    })
    vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua builtin<CR>", {
        desc = "fzf find fzflua-commands"
    })
    vim.keymap.set("n", "<leader>fo", "<cmd>FzfLua oldfiles<CR>", {
        desc = "fzf find fzflua-commands"
    })
    vim.keymap.set("n", "<leader>fu", "<cmd>FzfLua buffers<CR>", {
        desc = "fzf find buffers"
    })
    vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua resume<CR>", {
        desc = "fzf resume"
    })
    vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", {
        desc = "fzf help"
    })
    vim.keymap.set("n", "<leader>f,", "<cmd>FzfLua nvim_options<CR>", {
        desc = "fzf vim_options"
    })
    vim.keymap.set("n", "<leader>fw", "<cmd>FzfLua live_grep_native<CR>", {
        desc = "fzf live grep"
    })
    vim.keymap.set("n", "<leader>ff", function()
        require("fzf-lua").files({
            cmd = "fd --type f --exclude node_modules"
        })
    end, {
        desc = "fzf find files"
    })

    vim.pack.add({"https://github.com/saghen/blink.cmp"}, {
        confirm = false
    })
    require("blink.cmp").setup({
        completion = {
            documentation = {
                auto_show = true
            }
        },
        keymap = {
            ['<C-p>'] = {'select_prev', 'fallback_to_mappings'},
            ['<C-n>'] = {'select_next', 'fallback_to_mappings'},
            ['<C-y>'] = {'select_and_accept', 'fallback'},
            ['<C-e>'] = {'cancel', 'fallback'},
            ['<C-space>'] = {'show', 'show_documentation', 'hide_documentation'},
            ['<Tab>'] = {'snippet_forward', 'fallback'},
            ['<S-Tab>'] = {'snippet_backward', 'fallback'},
            ['<C-b>'] = {'scroll_documentation_up', 'fallback'},
            ['<C-f>'] = {'scroll_documentation_down', 'fallback'},
            ['<C-k>'] = {'show_signature', 'hide_signature', 'fallback'}
        },
        fuzzy = {
            implementation = "lua"
        }
    })

    vim.cmd("packadd nvim.undotree")
    vim.keymap.set("n", "<A-u>", require("undotree").open)
    vim.cmd("packadd nvim.difftool")

    vim.pack.add({"https://github.com/xiyaowong/transparent.nvim"})
    require('transparent').setup({
        groups = {'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier', 'Statement', 'PreProc', 'Type',
                  'Underlined', 'Todo', 'String', 'Function', 'Conditional', 'Repeat', 'Operator', 'Structure',
                  'LineNr', 'NonText', 'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
                  'EndOfBuffer', 'MiniFilesNormal', 'MiniFilesTitleFocused', 'MiniFilesFile', 'MiniStatuslineFilename',
                  'MiniStatuslineinfo', 'MiniStatuslineInactive', 'MiniClueDescSingle', 'LazyNormal',
                  'BlinkCmpMenuBorder', 'BlinkCmpKind', 'BlinkCmpMenu', 'ModeMsg'}
    })

    -- Toggle quickfix/location list
    vim.keymap.set("n", "<leader>q", function()
        local windows = vim.fn.getwininfo()
        for _, win in pairs(windows) do
            if win.quickfix == 1 then
                vim.cmd("cclose")
                return
            end
        end
        vim.cmd("copen")
    end, {
        desc = "Toggle quickfix list"
    })
    vim.keymap.set("n", "<leader>l", function()
        local windows = vim.fn.getwininfo()
        for _, win in pairs(windows) do
            if win.loclist == 1 then
                vim.cmd("lclose")
                return
            end
        end
        vim.cmd("lopen")
    end, {
        desc = "Toggle locatoin list"
    })

    -- Auto create dir when saving a file, in case some intermediate directory does not exist
    vim.api.nvim_create_autocmd({"BufWritePre"}, {
        group = vim.api.nvim_create_augroup("auto_create_dir", {
            clear = true
        }),
        callback = function(event)
            if event.match:match("^%w%w+:[\\/][\\/]") then
                return
            end
            local file = vim.uv.fs_realpath(event.match) or event.match
            vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
        end
    })

    require("vim._core.ui2").enable {
        enable = true,
        msg = { -- Options related to the message module.
            ---@type 'cmd'|'msg' Default message target, either in the
            ---cmdline or in a separate ephemeral message window.
            ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
            ---or table mapping |ui-messages| kinds and triggers to a target.
            targets = "cmd",
            cmd = { -- Options related to messages in the cmdline window.
                height = 0.5 -- Maximum height while expanded for messages beyond 'cmdheight'.
            },
            dialog = { -- Options related to dialog window.
                height = 0.5 -- Maximum height.
            },
            msg = { -- Options related to msg window.
                height = 0.5, -- Maximum height.
                timeout = 4000 -- Time a message is visible in the message window.
            },
            pager = { -- Options related to message window.
                height = 0.5 -- Maximum height.
            }
        }
    }

    -- Custom highlight for yank and paste
    vim.api.nvim_create_autocmd("TextYankPost", {
        pattern = "*",
        callback = function()
            vim.highlight.on_yank({
                higroup = "Visual",
                timeout = 200
            })
        end
    })

    vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", {
        desc = "Show LSP Info"
    })

    vim.api.nvim_create_user_command("LspLog", function(_)
        local state_path = vim.fn.stdpath("state")
        local log_path = vim.fs.joinpath(state_path, "lsp.log")

        vim.cmd(string.format("edit %s", log_path))
    end, {
        desc = "Show LSP log"
    })

    vim.api.nvim_create_user_command("LspRestart", "lsp restart", {
        desc = "Restart LSP"
    })

    -- incremental selection treesitter/lsp
    vim.keymap.set({"n", "x", "o"}, "<A-o>", function()
        if vim.treesitter.get_parser(nil, nil, {
            error = false
        }) then
            require("vim.treesitter._select").select_parent(vim.v.count1)
        else
            vim.lsp.buf.selection_range(vim.v.count1)
        end
    end, {
        desc = "Select parent treesitter node or outer incremental lsp selections"
    })

    vim.keymap.set({"n", "x", "o"}, "<A-i>", function()
        if vim.treesitter.get_parser(nil, nil, {
            error = false
        }) then
            require("vim.treesitter._select").select_child(vim.v.count1)
        else
            vim.lsp.buf.selection_range(-vim.v.count1)
        end
    end, {
        desc = "Select child treesitter node or inner incremental lsp selections"
    })

    vim.lsp.config['lua_ls'] = {
        cmd = {'lua-language-server'},
        filetypes = {'lua'},
        root_markers = {{'.luarc.json', '.luarc.jsonc'}, '.git'}
    }

    vim.lsp.enable('lua_ls')
end

