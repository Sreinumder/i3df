local map = vim.keymap.set
-- local nomap = vim.keymap.del
-- if not vim.g.vscode then
-- end

-- clever j k
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "gj", "j", { desc = "next line" })
map({ "n", "x" }, "gk", "k", { desc = "prev line" })
map({ "n", "x" }, "<A-n>", ";", { desc = "Down" })
map({ "n", "x" }, "<A-p>", ",", { desc = "Up" })

map("n", "<leader>w", "<C-w>", { desc = "window control" }) -- split window vertically
map({ "n", "v", "o" }, "H", "^", { desc = "Beg of line" })
-- map({ "n", "v", "o" }, "M", "gM", { desc = "Mid of Line" })
map({ "n", "v", "o" }, "L", "g_", { desc = "End of Line" })
map("x", "$", "g_", { desc = "Default last non-white char" })
map("x", "g_", "$")

-- pain saver
map(
	"n",
	"<Esc>",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-l><CR>",
	{ desc = "Redraw / Clear hlsearch / Diff Update" }
)
map("x", "J", "j", { desc = "Disable annoying J " })
map("n", "<leader>gv", "printf('`[%s`]', getregtype()[0])", { expr = true, desc = "reselect last paste" })
map("n", "<leader>v", "V", {  desc = "Line select" })
map({ "o", "x" }, "i<space>", "iW") -- select WORD by i<space>
map("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Lazy Menu" })

-- cd to things
map("n", "<leader>dh", "<cmd>cd ..<CR><cmd>pwd<cr>", { desc = "cd .." })
map("n", "<leader>df", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "cd to buf" })
map("n", "<leader>dg", function()
	local git_root = vim.fn.trim(vim.fn.system("git rev-parse --show-toplevel"))
	if vim.fn.isdirectory(git_root) == 1 then
    vim.cmd("cd " .. git_root)
	else
		print("Not inside a Git repository")
	end
end, { desc = "cd to Git repository root" })

-- clipboard management
-- clipboard to vim default register. usage: copy from browser to vim: <C-c>(in browser) ,p in vim
map({"n", "x"}, ",", function() vim.fn.setreg('"', vim.fn.getreg('+')) end, {desc = 'hack clipboard to vim reg'})
-- vim default register to clipboard. usage: copy from vim to other: <y <C-v>(in browser)
map({"n", "x"}, "<", function() vim.fn.setreg('+', vim.fn.getreg('"')) end, {desc = 'hack vim reg to clipboard'})

-- delete with x d or D and cut with alt + x, alt + d, alt + D, alt + c
map({ "n", "x" }, "x", '"_x')
map({ "n", "x" }, "X", '"_X')
map({ "n", "x" }, "d", '"_d')
map({ "n", "x" }, "D", '"_D')
map({ "n", "x" }, "c", '"_c')
map({ "n", "x" }, "C", '"_C')
map({ "n", "x" }, "<A-x>", "x")
-- never used this actually tho but still here
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

-- paste, or add line below
map("n", "<leader>p", "m`o<ESC>p==``", { desc = "paste below current line(jump)" })
map("n", "<leader>P", "m`O<ESC>p==``", { desc = "paste above current line(jump)" })
map("n", "<leader>o", "printf('m`%so<ESC>``', v:count1)", { expr = true, desc = "insert line below" })
map("n", "<leader>O", "printf('m`%sO<ESC>``', v:count1)", { expr = true, desc = "insert line above" })

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
map("x", "gl", '"bdW"bP`[v`]', { desc = "move selection with W" })
map("x", "gh", '"bdB"bP`[v`]', { desc = "move selection with b" })
map("x", "<A-H>", '"bd^"bP`[v`]', { desc = "move selection with H" })
map("x", "<A-L>", '"bd$"bp`[v`]', { desc = "move selection with L" })
map("x", "<A-g><A-g>", '"bdgg"bp`[v`]', { desc = "move selection with gg" })
map("x", "<A-G>", '"bdG"bp`[v`]', { desc = "move selection with G" })

-- simple hacks
map("n", "<C-s>", "<cmd>w<cr>", { silent = true, desc = "hack save this buffer" })
map("n", "<leader>qq", "<cmd>q!<cr>", { silent = true, desc = "hack quit current window" })

-- insert mode hack
-- Add undo break-points
map("i", ",", ",<c-g>u", {desc = "Insert-mode"})
map("i", ".", ".<c-g>u", {desc = "Insert-mode"})
map("i", ";", ";<c-g>u", {desc = "Insert-mode"})
map("i", "<C-l>", '<C-r>=expand("%:p:h") . "/" <CR>', { desc = "Insert-mode file path" })


map({ "i", "c", "t" }, "<A-;>", "<Esc>", { desc = "Insert-mode Escape" })
map({ "i", "c", "t" }, "<C-a>", "<Home>", { desc = "Insert-mode Home" })
map({ "i", "c", "t" }, "<C-e>", "<End>", { desc = "Insert-mode End" })
map({ "i", "c", "t" }, "<A-h>", "<Left>", { desc = "Insert-mode left" })
map({ "i", "c", "t" }, "<A-j>", "<Down>", { desc = "Insert-mode down" })
map({ "i", "c", "t" }, "<A-k>", "<Up>", { desc = "Insert-mode up" })
map({ "i", "c", "t" }, "<A-l>", "<Right>", { desc = "Insert-mode Right" })
map("c", "<C-A-K>", "\\(.*\\)", { desc = "Cmd-mode catching group/kirby " })

map("t", "<C-<ESC>", "<C-\\><C-n>", { desc = "terminal exit" })

-- easier commenting
map({"n","x"}, "<leader>/", "gcc", { remap = true, silent = true, desc = "comment"  })
map({"n","x"}, "<C-/>", "gcc", { remap = true, silent = true, desc = "comment"  })
map({"n","x"}, "<leader>c", "gc", { remap = true, silent = true, desc = "comment"  })
map({"n","x"}, "<leader>cv", "gcgc", { remap = true, silent = true, desc = "comment toggle comment body"})
map("n", "<leader>co", "Ox<ESC>gcc$xa", { remap = true, silent = true, desc = "comment above" })
map("n", "<leader>ca", "ox<ESC>gcc$xkJA", { remap = true, silent = true, desc = "comment at end" })

-- ========================
-- Diff mappings
-- ========================
vim.cmd([[command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis]])
-- map("n", "<leader>sc", "<cmd>DiffOrig<CR>", { desc = "diff unsaved changes" }) -- this is <C-k> + d in vscode
-- map('n', '<leader><leader>dt', ':windo diffthis<CR>', { noremap = true })
-- map('n', '<leader><leader>do', ':windo diffoff<CR>', { noremap = true })
