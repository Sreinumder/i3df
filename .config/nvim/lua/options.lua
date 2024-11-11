require "nvchad.options"
local opt = vim.opt

opt.tabstop         = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth      = 2 -- 2 spaces for indent width
opt.expandtab       = true -- expand tab to spaces
opt.autoindent      = true -- copy indent from current line when starting new one
opt.wrap            = true -- enable line wrapping


opt.number = true
opt.relativenumber = true
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- opt.rulerformat = ""
opt.cursorline = true -- highlight the current cursor line
-- opt.cursorcolumn = true -- highlight the current cursor column
-- opt.cursorlineopt = "number"
--setlocal cc=80
-- vim.g.cc = 80
vim.g.colorcolumn = 80


-- turn on termguicolors for nightfly colorscheme to work
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- hide the ~ character on empty lines at the end of the buffer
opt.fcs = "eob: "

opt.spell = false
opt.spelllang = { 'en_us' }

vim.g.netrw_banner = 0 -- disable that anoying Netrw banner
vim.g.netrw_browser_split = 4 -- open in a prior window
vim.cmd("let g:netrw_liststyle = 3") -- tree view

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
