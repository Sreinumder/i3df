local map = vim.keymap.set
local nomap = vim.keymap.del
if not vim.g.vscode then
end

-- clever j k
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "gj", "j", { desc = "next line" })
map({ "n", "x" }, "gk", "k", { desc = "prev line" })
map({ "n", "x" }, "<A-n>", ";", { desc = "Down" })
map({ "n", "x" }, "<A-p>", ",", { desc = "Up" })

map("n", "<leader>w", "<C-w>", { desc = "window control" }) -- split window vertically
map({ "n", "x" }, "<leader>r", '"', { desc = "register select" }) -- <leader>ra for a register
map({ "n", "v", "o" }, "H", "^", { desc = "Beg of line" })
map({ "n", "v", "o" }, "M", "gM", { desc = "Mid of Line" })
map({ "n", "v", "o" }, "L", "g_", { desc = "End of Line" })
--and HML to start mid end of line <A-HML> to high middle low part of screen
map("n", "<A-H>", "H", { desc = "Default H" })
map("n", "<A-M>", "M", { desc = "Default M" })
map("n", "<A-L>", "L", { desc = "Default L" })
map("x", "$", "g_", { desc = "to last non-white char" })
map("x", "g_", "$")

-- pain saver
map(
	"n",
	"<Esc>",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / Clear hlsearch / Diff Update" }
)
map("x", "J", "j", { desc = "Disable annoying J " })
map("n", "gV", "printf('`[%s`]', getregtype()[0])", { expr = true, desc = "true" }) -- Reselect last paste
map("n", "<leader>gv", "printf('`[%s`]', getregtype()[0])", { expr = true, desc = "true" }) -- Reselect last paste
map({ "o", "x" }, "i<space>", "iW") -- select WORD by i<space>
map("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Lazy nvim" })

-- cd to things
map("n", "<leader>dh", "<cmd>cd ..<CR>", { desc = "cd .." })
map("n", "<leader>df", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "cd to buf" })
map("n", "<leader>dg", function()
	local git_root = vim.fn.trim(vim.fn.system("git rev-parse --show-toplevel"))
	if vim.fn.isdirectory(git_root) == 1 then
		vim.cmd("cd " .. git_root)
	else
		print("Not inside a Git repository")
	end
end, { desc = "Change directory to Git repository root" })

-- clipboard management
-- clipboard to vim default register. usage: copy from browser to vim: <C-c>(in browser) <S-Space>p in vim
map({"n", "x"}, "<", function() vim.fn.setreg('"', vim.fn.getreg('+')) end, {desc = 'clipboard to vim reg'})
-- vim default register to clipboard. usage: copy from vim to other: yy<leader><leader> <C-v>(in browser)
map({"n", "x"}, ">", function() vim.fn.setreg('+', vim.fn.getreg('"')) end, {desc = 'vim reg to clipboard'})

-- delete with x d or D and cut with alt + x, alt + d, alt + D, alt + c
map({ "n", "x" }, "x", '"_x')
map({ "n", "x" }, "X", '"_X')
map({ "n", "x" }, "d", '"_d')
map({ "n", "x" }, "D", '"_D')
map({ "n", "x" }, "c", '"_c')
map({ "n" }, "c", '"_c')
-- map({ "n", "x" }, "cc", '"_cc')
map({ "n", "x" }, "C", '"_C')
map({ "n", "x" }, "<A-x>", "x")
map({ "n", "x" }, "<A-X>", "X")
map({ "n", "x" }, "<A-d>", "d")
map({ "n", "x" }, "<A-D>", "D")
map({ "n", "x" }, "<A-c>", "c")
map({ "n", "x" }, "<A-C>", "C")
map({ "n", "x" }, "<A-d><A-d>", "dd")
map({ "n", "x" }, "<A-c><A-c>", "cc")
map({ "v", "x" }, "p", '"_dP')
map({ "v", "x" }, "P", '"_dp')
map({ "v", "x" }, "<A-p>", "p")
map({ "v", "x" }, "<A-P>", "P")

-- paste, delete or (add/join empty line) below and above
map("n", "<leader>p", "m`o<ESC>p==``", { desc = "paste below current line(jump)" })
map("n", "<leader>P", "m`O<ESC>p==``", { desc = "paste above current line(jump)" })
map("n", "<A-a>", "printf('m`%so<ESC>``', v:count1)", { expr = true, desc = "insert line below" })
map("n", "<A-i>", "printf('m`%sO<ESC>``', v:count1)", { expr = true, desc = "insert line above" })

-- clone sentences up and down
map("n", "<A-J>", 'V"cy"cP==gv<Esc>', { desc = "clone line Down" })
map("n", "<A-K>", 'V"cy"cgp==gv<Esc>', { desc = "clone line Up" })
map("x", "<A-J>", '"cy"cP==gv', { desc = "clone selection Down" })
map("x", "<A-K>", '"cy"cgp==gv', { desc = "clone selection Up" })

-- move/clone selection to new line above or below
map("x", "<leader><A-j>", '"bdo<esc>"bp==', { desc = "move selection Down(v) to new line" })
map("x", "<leader><A-k>", '"bdO<esc>"bp==', { desc = "move selection Up(v) to new line" })
map("x", "<leader><A-J>", '"byo<esc>"bp==', { desc = "clone selection Down(v) to new line" })
map("x", "<leader><A-K>", '"byO<esc>"bp==', { desc = "clone selection Up(v) to new line" })

-- move selection with vi motion of web(ge)/WEB(GE)/HML/gg/G
-- map("n", "<A-v>", "vlh", { desc = "vi single char under cursor" })
map("x", "gl", '"bdW"bP`[v`]', { desc = "move selection with W" })
map("x", "gh", '"bdB"bP`[v`]', { desc = "move selection with b" })
map("x", "<A-H>", '"bd^"bP`[v`]', { desc = "move selection with H" })
map("x", "<A-L>", '"bd$"bp`[v`]', { desc = "move selection with L" })
map("x", "<A-g><A-g>", '"bdgg"bp`[v`]', { desc = "move selection with gg" })
map("x", "<A-G>", '"bdG"bp`[v`]', { desc = "move selection with G" })

-- simple hacks
map("n", "<C-s>", "<cmd>w<cr>", { silent = true, desc = "save this buffer" })
map("n", "<leader>qq", "<cmd>q!<cr>", { silent = true, desc = "quit current window" })
map("n", "<leader>sa", "<cmd>wqa!<cr>", { silent = true, desc = "write and quit all" })
map("n", "<leader>wa", "<cmd>wa<cr>", { silent = true, desc = "save all buffer" })
map("n", "<leader>qa", "<cmd>qa!<cr>", { silent = true, desc = "quit nvim" }) -- Quit all opened buffers

-- insert mode hack
-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")
map("i", "<c-u>", "<Esc>viw~ea", { desc = "toggle case" })
map("i", "<c-t>", "<Esc>b~lea", { desc = "change word case to title" })
map("i", "<C-l>", '<C-r>=expand("%:p:h") . "/" <CR>', { desc = "write file path" })

map({ "i", "c", "t" }, "<A-h>", "<Left>", { desc = "Insert mode left" })
map({ "i", "c", "t" }, "<A-j>", "<Down>", { desc = "Insert mode down" })
map({ "i", "c", "t" }, "<A-k>", "<Up>", { desc = "Insert mode up" })
map({ "i", "c", "t" }, "<A-l>", "<Right>", { desc = "Insert mode Right" })
map("c", "<C-A-K>", "\\(.*\\)", { desc = "kirby " })

map("t", "<C-<ESC>", "<C-\\><C-n>", { desc = "exit in terminal mode" })

-- toggle options
map({ "n", "x" }, "<leader>,wr", "<cmd>set wrap!<CR>", { desc = "Toggle wrap" })
map({ "n", "x" }, "<leader>,sp", "<cmd>set spell!<CR>", { desc = "Toggle spell" })
map({ "n", "x" }, "<leader>,cl", "<cmd>set cursorline!<CR>", { desc = "Toggle cursorline" })
map({ "n", "x" }, "<leader>,ii", "<cmd>set list!<CR>", { desc = "Toggle invisible char" })
-- map({ "n", "x" }, "<leader>,ct", function()
--   if vim.opt.background:get() == "dark" then
-- 		vim.cmd(":set bg=light")
-- 	else
-- 		vim.cmd(":set bg=dark")
-- 	end
-- end, { desc = "Toggle colorscheme bg" })

-- ========================
-- Diff mappings
-- ========================
vim.cmd([[command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis]])
map("n", "<leader>sc", "<cmd>DiffOrig<CR>", { desc = "unsaved changes diff" })
map('n', '<leader><leader>dt', ':windo diffthis<CR>', { noremap = true })
map('n', '<leader><leader>do', ':windo diffoff<CR>', { noremap = true })
