local o = vim.opt
local g = vim.g

if not g.vscode then
	-- require("nvchad.oions")
	-- Numbers
	o.wrap = true -- enable line wrappingo.number           = true
	o.relativenumber = true
	o.numberwidth = 1
	o.number = true
	o.tabstop = 2 -- 2 spaces for tabs (prettier default)
	o.shiftwidth = 2 -- 2 spaces for indent width
	o.softtabstop = 2
	o.expandtab = true -- expand tab to spaces
	o.autoindent = true -- copy indent from current line when starting new one
	o.ignorecase = true -- ignore case when searching
	o.smartcase = true -- iif you include mixed case in your search, assumes you want case-sensitive
	-- o.ruler = false
	o.shortmess:append("sI") -- disable nvim intro
else
	-- o.shortmess:append("c")
	g.neovim_log_level = 0 -- Disable logging output from Neovim
end

-- o.laststatus = 3
-- o.showmode = false

-- o.fillchars = { eob = " " }
-- o.ignorecase = true
-- o.smartcase = true
-- o.mouse = "a"

-- o.signcolumn = "yes"
-- o.splitbelow = true
-- o.splitright = true
-- o.timeoutlen = 400
o.undofile = true
--
-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
-- o.whichwrap:append "<>[]hl"

local is_windows = vim.fn.has("win32") ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH
-- o.clipboard:append("unnamedplus") -- use system clipboard as default register

-- o.rulerformat   = ""
o.cmdheight = 0 -- sets cmdline height
o.cursorline = true -- highlight the current cursor line
-- o.cursorcolumn  = true -- highlight the current cursor column
-- o.cursorlineo = "number"
--setlocal cc        = 80
-- g.cc          = 80
g.colorcolumn = 80 -- turn on termguicolors for nightfly colorscheme to work
o.background = "dark" -- colorschemes that can be light or dark will be made dark
o.signcolumn = "yes" -- show sign column so that text doesn't shift
o.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
o.undolevels = 10000
o.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
o.wildmode = "longest:full,full" -- Command-line completion mode
o.winminwidth = 5 -- Minimum window width

-- split windows
o.splitright = true -- split vertical window to the right
o.splitbelow = true -- split horizontal window to the bottom

-- hide the ~ character on empty lines at the end of the buffer
o.fcs = "eob: "

o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions" -- better auto-session
o.spell = false
o.spelllang = { "en_us" }
o.foldcolumn = "1" -- '0' is not bad
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true
g.netrw_banner = 0 -- disable that anoying Netrw banner
g.netrw_browser_split = 4 -- open in a prior windowvim.cmd("let g:netrw_liststyle = 3") -- tree view
g.matchup_matchparen_offscreen = { method = "popup" }

-- Disable sql omni completion, it is broken.
g.loaded_sql_completion = 1
g.nvim_ghost_server_port = 4001
g.nvim_ghost_autostart = 0

o.listchars = {
	tab = "▸┊",
	trail = "▫",
	nbsp = "␣",
	extends = "❯",
	precedes = "❮",
}

-- plugin parameters
g.preserve_cursor_pos = true
g.change_hl_duration = 500

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

g.neovide_transparency = 0.8
