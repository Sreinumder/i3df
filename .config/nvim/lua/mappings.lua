if not vim.g.vscode then
    require("nvchad.mappings")
end
local map = vim.keymap.set
local nomap = vim.keymap.del

-- clever j k
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "gj", "j", { desc = "next line" })
map({ "n", "x" }, "gk", "k", { desc = "prev line" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize   +2<cr>", { desc = "Increase Window    Height" })
map("n", "<C-Down>", "<cmd>resize   -2<cr>", { desc = "Decrease Window    Height" })
map("n", "<C-Left>", "<cmd>vertical resize   -2<cr>", { desc = "Decrease Window  Width" })
map("n", "<C-Right>", "<cmd>vertical resize   +2<cr>", { desc = "Increase Window  Width" })
-- map("n", "<Up>", "<C-W>k", { desc = "Window up" })
-- map("n", "<Down>", "<C-W>j", { desc = "Window down" })
-- map("n", "<Left>", "<C-W>h", { desc = "Window left" })
-- map("n", "<Right>", "<C-W>l", { desc = "Window right" })


--and HML to start mid end of line <A-HML> to high middle low part of screen
map("n", "<leader>w", "<C-w>", { desc = "window control" })       -- split window vertically
map({ "n", "x" }, "<leader>r", '"', { desc = "register select" }) -- <leader>ra for a register
map("n", "ygG", "<cmd>%y+<CR>", { desc = "yank all" })
map({ "n", "v", "o" }, "H", "^",  { desc = "Beg of line" }) map("n", "<A-H>", "H", { desc = "Default H" })
map({ "n", "v", "o" }, "M", "gM", { desc = "Mid of Line" }) map("n", "<A-M>", "M", { desc = "Default M" })
map({ "n", "v", "o" }, "L", "g_", { desc = "End of Line" }) map("n", "<A-L>", "L", { desc = "Default L" })
map("x", "$", "g_", { desc ="to last non-white char"}) map("x", "g_", "$")

-- LSP
map("n", "gr",         vim.lsp.buf.references,     { desc = "Show references"      })
map("n", "gd",         vim.lsp.buf.definition,     { desc = "Go to lsp definition" }) map("n", "<Leader>gd", "gd")
map("n", "gD",         vim.lsp.buf.declaration,    { desc = "Go to lsp declaration"}) map("n", "<Leader>gD", "gD")
map("n", "<leader>D",  vim.lsp.buf.type_definition,{ desc = "Go to type definition"})
map("n", "gi",         vim.lsp.buf.implementation, { desc = "Go to implementation" }) map("n", "<Leader>gi", "gi")
map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, {desc = "Code action"})
map("n", "<leader>wi", vim.lsp.buf.add_workspace_folder, { desc = "Insert workspace folder" })
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
-- map("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,{ desc= "List workspace folders"})

-- pain saver
map("n", "<leader>", "<NOP>", { desc = "" })
map("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })
map("n", "<leader>nh",
    "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / Clear hlsearch / Diff Update" }
)
map("x", "J", "j", { desc = "Disable annoying J " })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
map("x", "<", "<gv")
map("x", ">", ">gv")                                                                -- Continuous visual shifting (does not exit Visual mode), `gv` means
map("n", "gV", "printf('`[%s`]', getregtype()[0])", { expr = true, desc = "true" }) -- Reselect last paste
-- map("n", "vih", "^vg_", { desc = "true" })
-- map("n", "yih", "^yg_", { desc = "true" })
map({ "o", "x" }, "i<space>", "iW") -- select WORD by i<space>
-- others
map("n", "<leader>L", ":Lazy<CR>", { desc = "Lazy nvim" })
map({ "n", "x" }, "<leader>*", "*``cgn", { desc = "replace word" })
for _, quote in ipairs({ '"', "'", "`" }) do
	vim.keymap.set({ "x", "o" }, "a" .. quote, "2i" .. quote)
end

-- cd to things
map("n", "<leader>cdh", ":cd ..<CR>", { desc = "cd .." })
map("n", "<leader>cdf", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "change dir" })
map("n", "<leader>cdp", "<cmd>lcd ~/.config/nvim/lua/plugins<cr>", { desc = "change dir to nvim config" })
map("n", "<leader>cdr", "<cmd>lcd ~<cr>", { desc = "change dir to ~" })
map("n", "<leader>cdn", "<cmd>lcd ~/notes<cr>", { desc = "change dir to notes" })
vim.keymap.set("n", "<leader>cdg", function()
  local git_root = vim.fn.trim(vim.fn.system("git rev-parse --show-toplevel"))
  if vim.fn.isdirectory(git_root) == 1 then
    vim.cmd("cd " .. git_root)
  else
    print("Not inside a Git repository")
  end
end, { desc = "Change directory to Git repository root" })

-- delete with x d or D and cut with alt + x + d + D
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
map("n", "<leader>p", "m`o<ESC>p``", { desc = "paste below current line(jump)" })
map("n", "<leader>P", "m`O<ESC>p``", { desc = "paste above current line(jump)" })
map("n", "<A-a>", "printf('m`%so<ESC>``', v:count1)", { expr = true, desc = "insert line below" })
map("n", "<A-i>", "printf('m`%sO<ESC>``', v:count1)", { expr = true, desc = "insert line above" })
map("x", "<A-a>", "<esc>o<esc>gv", { desc = "insert line below" })
map("x", "<A-i>", "<esc>O<esc>gv", { desc = "insert line above" })
map("n", "<A-A>", '<esc>j"_ddk', { desc = "delete the line below" })
map("n", "<A-I>", '<esc>k"_dd', { desc = "delete the line above" })
map("n", "<A-m>", "o<esc>kO<esc>j", { desc = "insert new line below and above" })
map("x", "<A-m>", "<esc>a<Enter><esc>gvo<esc>i<Enter><esc>^vg_", { desc = "insert new line below and above" })
map("n", "<A-n>", "JkJ", { desc = "join with prev and next line" })
map("x", "<A-n>", ":j<cr>^mgk$JJgv", { desc = "join with prev and next line" })


-- comment and clone sentence
-- map("n", "<A-y>", 'gcc', { desc = "clone line Down(n)" })

-- simple editing hacks
-- clone sentences up and down
map("n", "<A-J>", 'V"by"bPgv<Esc>', { desc = "clone line Down(n)" })
map("n", "<A-K>", 'V"by"bgpgv<Esc>', { desc = "clone line Up(n)" })
map("x", "<A-J>", '"by"bPgv', { desc = "clone selection Down(v)" })
map("x", "<A-K>", '"by"bgpgv', { desc = "clone selection Up(v)" })

-- move/clone selection to new line above or below
map("x", "<leader><A-j>", '"bdo<esc>"bp^vg_', { desc = "move selection Down(v) to new line" })
map("x", "<leader><A-k>", '"bdO<esc>"bp^vg_', { desc = "move selection Up(v) to new line" })
map("x", "<leader><A-J>", '"byo<esc>"bp^vg_', { desc = "clone selection Down(v) to new line" })
map("x", "<leader><A-K>", '"byO<esc>"bp^vg_', { desc = "clone selection Up(v) to new line" })

-- move selection with vi motion of web(ge)/WEB(GE)/HML/gg/G
map("n", "<A-v>", "vlh", { desc = "vi single char under cursor" })
map("x", "<A-w>", '"bdw"bp`[v`]', { desc = "move selection with w" })
map("x", "<A-e>", '"bde"bp`[v`]', { desc = "move selection with e" })
map("x", "<A-b>", '"bdb"bP`[v`]', { desc = "move selection with b" })
map("x", "<A-W>", '"bdW"bp`[v`]', { desc = "move selection with W" })
map("x", "<A-E>", '"bdE"bp`[v`]', { desc = "move selection with e" })
map("x", "<A-B>", '"bdB"bP`[v`]', { desc = "move selection with b" })
map("x", "<A-H>", '"bd^"bP`[v`]', { desc = "move selection with H" })
map("x", "<A-M>", '"bdgM"bP`[v`]',{ desc = "move selection with H" })
map("x", "<A-L>", '"bd$"bp`[v`]', { desc = "move selection with L" })
map("x", "<A-g><A-e>", '"bdge"bp`[v`]', { desc = "move selection with ge" })
map("x", "<A-g><A-E>", '"bdgE"bp`[v`]', { desc = "move selection with gE" })
map("x", "<A-g><A-g>", '"bdgg"bp`[v`]', { desc = "move selection with gg" })
map("x", "<A-G>", '"bdG"bp`[v`]', { desc = "move selection with G" })

-- simple hacks
-- map("n", "<leader>ql", "<cmd>lopen<cr>", { desc = "Location List" })
-- map("n", "<leader>qf", "<cmd>copen<cr>", { desc = "Quickfix List" })
map("n", "<leader>ww", ":w<cr>", { silent = true, desc = "save this buffer" })
map("n", "<leader>qq", "<cmd>q!<cr>", { silent = true, desc = "quit current window" })
map("n", "<leader>sa", "<cmd>wqa!<cr>", { silent = true, desc = "write and quit all" })
map("n", "<leader>qw", ":wq<cr>", { silent = true, desc = "save buffer" })
map("n", "<leader>wa", ":wa<cr>", { silent = true, desc = "save all buffer" })
map("n", "<leader>qa", "<cmd>qa!<cr>", { silent = true, desc = "quit nvim" })              -- Quit all opened buffers
map("n", "[l", "<cmd>lprevious<cr>zv", { silent = true, desc = "previous location item" }) -- Navigation in the location and quickfix list
map("n", "]l", "<cmd>lnext<cr>zv", { silent = true, desc = "next location item" })
map("n", "[L", "<cmd>lfirst<cr>zv", { silent = true, desc = "first location item" })
map("n", "]L", "<cmd>llast<cr>zv", { silent = true, desc = "last location item" })
map("n", "[q", "<cmd>cprevious<cr>zv", { silent = true, desc = "previous qf item" })
map("n", "]q", "<cmd>cnext<cr>zv", { silent = true, desc = "next qf item" })
map("n", "[Q", "<cmd>cfirst<cr>zv", { silent = true, desc = "first qf item" })
map("n", "]Q", "<cmd>clast<cr>zv", { silent = true, desc = "last qf item" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- insert mode hack
-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")
map("i", "<c-u>", "<Esc>viw~ea", { desc = "toggle case" })
map("i", "<c-t>", "<Esc>b~lea", { desc = "change word case to title" })
map("i", "<C-k>", function() -- capitalize word
	local line = vim.fn.getline(".")
	local col = vim.fn.getpos(".")[3]
	local substring = line:sub(1, col - 1)
	local result = vim.fn.matchstr(substring, [[\v<(\k(<)@!)*$]])
	return "<C-w>" .. result:upper()
end, { expr = true })
map("i", "<C-l>", '<C-r>=expand("%:p:h") . "/" <CR>', { desc = "write file path" })

--- Emacs style
map({ "i", "c", "t" }, "<A-h>", "<Left>", { desc = "Insert mode left" })
map({ "i", "c", "t" }, "<A-j>", "<Down>", { desc = "Insert mode down" })
map({ "i", "c", "t" }, "<A-k>", "<Up>", { desc = "Insert mode up" })
map({ "i", "c", "t" }, "<A-l>", "<Right>", { desc = "Insert mode Right" })
map({ "i", "c" }, "<C-A>", "<HOME>")
map({ "i", "c" }, "<C-E>", "<END>")
map("c", "<C-A-K>", "\\(.*\\)", { desc = "kirby " })

map("i", "<A-c>", "<esc>ciw", { desc = "change except the selection" })
map("i", "<A-n>", "<esc>2f,Bct,", { desc = "change next csv" })
map("i", "<A-p>", "<esc>F,Bct, ", { desc = "change prev csv" }) --   this, is, good, binding,

-- Automatically indent with i and A made by ycino
vim.keymap.set("n", "i", function()
	return vim.fn.len(vim.fn.getline(".")) ~= 0 and "i" or '"_cc'
end, { expr = true, silent = true })
vim.keymap.set("n", "A", function()
	return vim.fn.len(vim.fn.getline(".")) ~= 0 and "A" or '"_cc'
end, { expr = true, silent = true })

-- easier access for 67890:
map({ "n", "v", "o", "i" }, "<A-`>", "5")
map({ "n", "v", "o", "i" }, "<A-1>", "6")
map({ "n", "v", "o", "i" }, "<A-2>", "7")
map({ "n", "v", "o", "i" }, "<A-3>", "8")
map({ "n", "v", "o", "i" }, "<A-4>", "9")
map({ "n", "v", "o", "i" }, "<A-;>", "0")
map({ "n", "x" }, "<leader>l", ":")

-- toggle options
map("n", "<leader>,nn", ":set number!<CR>", { desc = "Toggle number" })
map("n", "<leader>,nr", ":set relativenumber!<CR>", { desc = "Toggle relative number" })
map("n", "<leader>,w", ":set wrap!<CR>", { desc = "Toggle wrap" })
map("n", "<leader>,sp", ":set spell!<CR>", { desc = "Toggle spell" })
map("n", "<leader>,cl", ":set cursorline!<CR>", { desc = "Toggle cursorline" })
map("n", "<leader>,ii", ":set list!<CR>", { desc = "Toggle invisible char" })
map("n", "<leader>,ct", function()
    if vim.opt.background:get() == "dark" then
        vim.cmd(":set bg=light")
    else
        vim.cmd(":set bg=dark")
    end
end, { desc = "Toggle colorscheme bg" })
