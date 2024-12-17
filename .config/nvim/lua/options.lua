local opt = vim.opt
if not vim.g.vscode then
	require "nvchad.options"
  -- Numbers
	opt.relativenumber   = true
  opt.numberwidth = 1
  opt.number = true
  -- o.ruler = false
end

opt.clipboard:append("unnamedplus") -- use system clipboard as default registeropt.undofile         = true
opt.tabstop          = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth       = 2 -- 2 spaces for indent width
opt.softtabstop      = 2
opt.expandtab        = true -- expand tab to spaces
opt.autoindent       = true -- copy indent from current line when starting new one
opt.wrap             = true -- enable line wrappingopt.number           = true
opt.ignorecase       = true -- ignore case when searching
opt.smartcase        = true -- if you include mixed case in your search, assumes you want case-sensitive

-- opt.rulerformat   = ""
opt.cmdheight      = 0
opt.cursorline       = true -- highlight the current cursor line
-- opt.cursorcolumn  = true -- highlight the current cursor column
-- opt.cursorlineopt = "number"
--setlocal cc        = 80
-- vim.g.cc          = 80
vim.g.colorcolumn    = 80 -- turn on termguicolors for nightfly colorscheme to work
opt.background       = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn       = "yes" -- show sign column so that text doesn't shift
opt.backspace        = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
opt.undolevels       = 10000
opt.virtualedit      = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode         = "longest:full,full" -- Command-line completion mode
opt.winminwidth      = 5 -- Minimum window width

-- split windows
opt.splitright       = true -- split vertical window to the right
opt.splitbelow       = true -- split horizontal window to the bottom

-- hide the ~ character on empty lines at the end of the buffer
opt.fcs              = "eob: "

opt.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions" -- better auto-session
opt.spell            = false
opt.spelllang        = { 'en_us' }
opt.foldcolumn     = '1' -- '0' is not bad
opt.foldlevel      = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable     = true
vim.g.netrw_banner        = 0 -- disable that anoying Netrw banner
vim.g.netrw_browser_split = 4 -- open in a prior windowvim.cmd("let g:netrw_liststyle = 3") -- tree view
vim.g.matchup_matchparen_offscreen = { method = "popup" }

-- Disable sql omni completion, it is broken.
vim.g.loaded_sql_completion = 1
vim.g.nvim_ghost_server_port = 4001
vim.g.nvim_ghost_autostart = 0

vim.opt.listchars = {
	tab = "▸▹┊",
	trail = "▫",
	nbsp = "␣",
	extends = "❯",
	precedes = "❮",
}

-- plugin parameters
vim.g.preserve_cursor_pos = true
vim.g.change_hl_duration = 300
