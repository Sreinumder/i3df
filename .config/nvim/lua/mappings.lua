require("nvchad.mappings")
local map = vim.keymap.set
local nomap = vim.keymap.del

 -- clever j k
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "gj", "j", { desc = "next line" })
map({ "n", "x" }, "gk", "k", { desc = "prev line" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>",    "<cmd>resize   +2<cr>", {        desc =    "Increase Window    Height" })
map("n", "<C-Down>",  "<cmd>resize   -2<cr>", {        desc =    "Decrease Window    Height" })
map("n", "<C-Left>",  "<cmd>vertical resize   -2<cr>", {    desc =         "Decrease Window  Width" })
map("n", "<C-Right>", "<cmd>vertical resize   +2<cr>", {    desc =         "Increase Window  Width" })
map("n", "<Up>",    "<C-W>k", { desc = "Window up" })
map("n", "<Down>",  "<C-W>j", { desc = "Window down" })
map("n", "<Left>",  "<C-W>h", { desc = "Window left"  })
map("n", "<Right>", "<C-W>l", { desc = "Window right"  })


--and HML to start mid end of line <A-HML> to high middle low part of screen
map("n", "<leader>w", "<C-w>", { desc = "window control" }) -- split window vertically
map({ "n", "x" }, "<leader>r", '"', { desc = "register select" }) -- <leader>ra for a register
map("n", "ygG", "<cmd>%y+<CR>", { desc = "yank all" })
map({ "n", "v", "o" }, "H", "^", { desc = "Start of line" })
map("n", "<A-H>", "H", { desc = "Default H" })
map({ "n", "v", "o" }, "M", "gM", { desc = "Middle of Line" })
map("n", "<A-M>", "M", { desc = "Default M" })
map({ "n", "v", "o" }, "L", "g_", { desc = "End of Line" })
map("n", "<A-L>", "L", { desc = "Default L" })
map("x", "$", "g_")
map("x", "g_", "$")

-- LSP
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to lsp declaration" })
map("n", "<Leader>gD", "gD", { desc = "Go to declaration" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to lsp definition" })
map("n", "<Leader>gd", "gd", { desc = "Go to definition" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Show signature help" })
map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Show signature help" })
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })

-- map("n", "<leader>wl", function()
--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- end, opts "List workspace folders")

-- map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
-- map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")

--   map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
--   map("n", "gr", vim.lsp.buf.references, opts "Show references")
-- end
-- pain saver
map("n", "<leader>", "<NOP>", { desc = "" })
map("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })
map( "n", "<leader>nh",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)
map("n", "<A-v>", "vlh", { desc = "vi single char under cursor" })
map("x", "J", "j", { desc = "Disable annoying J " })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
map("x", "<", "<gv")
map("x", ">", ">gv") -- Continuous visual shifting (does not exit Visual mode), `gv` means
map("n", "gV", "printf('`[%s`]', getregtype()[0])", { expr = true, desc = "true" }) -- Reselect last paste

-- others
map("n", "<leader>L", ":Lazy<CR>", { desc = "Lazy nvim" })
map({ "n", "x" }, "<leader>*", "*``cgn", { desc = "replace word" })
map("n", "/", [[/\v]]) -- Always use very magic mode for searching

-- cd to things
map("n", "<leader>cdh", ":cd ..<CR>", { desc = "cd.." })
map("n", "<leader>cdf", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "change dir" })
map("n", "<leader>cdp", "<cmd>lcd ~/.config/nvim/lua/plugins<cr>", { desc = "change dir to nvim config" })
map("n", "<leader>cdh", "<cmd>lcd ~<cr>", { desc = "change dir to ~" })
map("n", "<leader>cdn", "<cmd>lcd ~/notes<cr>", { desc = "change dir to notes" })

-- delete with x d or D and cut with alt + x + d + D
map({ "n", "v", "x" }, "x", '"_x')
map({ "n", "v", "x" }, "X", '"_X')
map({ "n", "v", "x" }, "d", '"_d')
map({ "n", "v", "x" }, "D", '"_D')
map({ "n", "v", "x" }, "c", '"_c')
map({ "n", "v", "x" }, "C", '"_C')
map({ "n", "v", "x" }, "<A-x>", "x")
map({ "n", "v", "x" }, "<A-X>", "X")
map({ "n", "v", "x" }, "<A-d>", "d")
map({ "n", "v", "x" }, "<A-D>", "D")
map({ "n", "v"}, "<A-c>", "c")
map({ "n", "v", "x" }, "<A-C>", "C")
map({ "n", "v", "x" }, "<A-d><A-d>", "dd")
map({ "n", "v"}, "<A-c><A-c>", "cc")
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

-- niche visual selection hacks
map("x", "<A-x>", '<esc>"_x`<"_xv`>h', { desc = "delete surrounding of visual mode" })
map("x", "<A-c>", '"bdo<esc>"bpk"_dd', { desc = "delete except the selection of current line" })

-- increase/decrease and shift visual selection
map("x", "<C-l>", "loho", { desc = "change vi range" })
map("x", "<C-h>", "holo", { desc = "change vi range" })
map("x", "<C-j>", "joko", { desc = "change vi range" })
map("x", "<C-k>", "kojo", { desc = "change vi range" })
map("x", "<C-S-l>", "lolo", { desc = "shift vi range" })
map("x", "<C-S-h>", "hoho", { desc = "shift vi range" })
map("x", "<C-S-j>", "jojo", { desc = "shift vi range" })
map("x", "<C-S-k>", "koko", { desc = "shift vi range" })

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
map("x", "<A-w>", '"bdw"bp`[v`]', { desc = "move selection with w" })
map("x", "<A-e>", '"bde"bp`[v`]', { desc = "move selection with e" })
map("x", "<A-b>", '"bdb"bP`[v`]', { desc = "move selection with b" })
map("x", "<A-W>", '"bdW"bp`[v`]', { desc = "move selection with W" })
map("x", "<A-E>", '"bdE"bp`[v`]', { desc = "move selection with e" })
map("x", "<A-B>", '"bdB"bP`[v`]', { desc = "move selection with b" })
map("x", "<A-H>", '"bd^"bP`[v`]', { desc = "move selection with H" })
map("x", "<A-M>", '"bdgM"bP`[v`]', { desc = "move selection with H" })
map("x", "<A-L>", '"bd$"bp`[v`]', { desc = "move selection with L" })
map("x", "<A-g><A-e>", '"bdge"bp`[v`]', { desc = "move selection with ge" })
map("x", "<A-g><A-E>", '"bdgE"bp`[v`]', { desc = "move selection with gE" })
map("x", "<A-g><A-g>", '"bdgg"bp`[v`]', { desc = "move selection with gg" })
map("x", "<A-G>", '"bdG"bp`[v`]', { desc = "move selection with G" })

-- simple hacks
map("n", "<leader>ll", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>qf", "<cmd>copen<cr>", { desc = "Quickfix List" })
map("n", "<leader>qw", ":exit<cr>", { silent = true, desc = "save buffer" }) -- Shortcut for faster save and quit
map("n", "<leader>qq", "<cmd>x<cr>", { silent = true, desc = "quit current window" }) -- Saves the file if modified and quit
map("n", "<leader>qa", "<cmd>qa!<cr>", { silent = true, desc = "quit nvim" }) -- Quit all opened buffers
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

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- insert / command mode hacks
map("n", "<leader>to", "o- [ ] ", { desc = "markdown todo below" })
map("n", "<leader>tO", "O- [ ] ", { desc = "markdown todo below" })
map("n", "<leader>tc", "cc- [ ] ", { desc = "markdown todo change" })
map("n", "<A-.>", ":<Up><CR>", { desc = "last command" })
map("i", "<c-u>", "<Esc>viw~ea", { desc = "toggle case" })
map("i", "<c-t>", "<Esc>b~lea", { desc = "change word case to title" })
map("i", "<C-l>", '<C-r>=expand("%:p:h") . "/" <CR>', { desc = "write file path" })

map({ "i", "c", "t" }, "<A-h>", "<Left>", { desc = "Insert mode left" })
map({ "i", "c", "t" }, "<A-j>", "<Down>", { desc = "Insert mode down" })
map({ "i", "c", "t" }, "<A-k>", "<Up>", { desc = "Insert mode up" })
map({ "i", "c", "t" }, "<A-l>", "<Right>", { desc = "Insert mode Right" })

map("i", "<A-H>", "<C-Left>", { desc = "Insert mode left" })
map("i", "<A-J>", "<C-Down>", { desc = "Insert mode down" })
map("i", "<A-K>", "<C-Up>", { desc = "Insert mode up" })
map("i", "<A-L>", "<C-Right>", { desc = "Insert mode Right" })

map("i", "<A-c>", "<esc>ciw", { desc = "change this word" })
map("i", "<A-n>", "<esc>2f,Bct,", { desc = "change next csv" })
map("i", "<A-p>", "<esc>F,Bct, ", { desc = "change prev csv" }) --   good, binding, this, is,

map({ "i", "c" }, "<C-A>", "<HOME>")
map({ "i", "c" }, "<C-E>", "<END>")
map("c", "<C-A-K>", "\\(.*\\)", { desc = "kirby " })

-- bash hack for sorting/shuffling/sequencing csv with <A-o> in normal or insert mode
-- {e, a, b, d, c, f, }
-- {a, b, c, d, e, f, }
-- shuf -i 1-10 -n 10 -r  | sed -z "s/\\n/, /g"
-- map("n", "<leader>vrl", 'i<enter><esc>!!shuf -i 1-10 -n 10 -r  | sed -z "s/\\n/, /g"<CR>kgJ')
map(
	"n",
	"<A-o>",
	'i<enter><enter><Up><esc>!! | sed -z "s/\\n/, /g"<Home><Right><Right>',
	{ desc = "genearate comma seperated seq or shuf or any bash output" }
)
map(
	"i",
	"<A-o>",
	'<enter><enter><Up><esc>!! | sed -z "s/\\n/, /g"<Home><Right><Right>',
	{ desc = "genearate comma seperated seq or shuf or any bash output" }
)
map(
	"x",
	"<A-o>",
	'<esc>a<Enter><esc>gvo<esc>i<Enter><esc>^"_d0vg_!sed "s/, */\\n/g"| grep -v "^$" |  | sed -z "s/\\n/, /g"<C-Left><C-Left><C-Left><C-Left><C-Left><C-Left>'
)
map(
	"x",
	"<leader>oso",
	'<esc>a<Enter><esc>gvo<esc>i<Enter><esc>^"_d0vg_!sed "s/, */\\n/g"| grep -v "^$" | sort -g | sed -z "s/\\n/, /g"<CR>kJxJhx'
)
map(
	"x",
	"<leader>osr",
	'<esc>a<Enter><esc>gvo<esc>i<Enter><esc>^"_d0vg_!sed "s/, */\\n/g"| grep -v "^$" | sort -gr | sed -z "s/\\n/, /g"<CR>kJxJhx'
)
map(
	"x",
	"<leader>oss",
	'<esc>a<Enter><esc>gvo<esc>i<Enter><esc>^"_d0vg_!sed "s/, */\\n/g"| grep -v "^$" | shuf | sed -z "s/\\n/, /g"<CR>kJxJhx'
)
map(
	"x",
	"<leader>on",
	'<esc>a<Enter><esc>gvo<esc>i<Enter><esc>^"_d0vg_!sed "s/, */\\n/g"| grep -v "^$" | wc -l<CR>kJxJhx'
)

-- bash filter magic with <leader>rs
map("n", "<leader>rs", '"byy"bp"bp0d}k!!sh<cr>', { desc = "bash filter append" })
map("n", "<leader>rS", "!!sh<cr>", { desc = "bash filter replace" })

-- easier access for 67890:
map({ "n", "v", "o", "i" }, "<A-`>", "5")
map({ "n", "v", "o", "i" }, "<A-1>", "6")
map({ "n", "v", "o", "i" }, "<A-2>", "7")
map({ "n", "v", "o", "i" }, "<A-3>", "8")
map({ "n", "v", "o", "i" }, "<A-4>", "9")
map({ "n", "v", "o", "i" }, "<A-;>", "0")
map({ "n", "x" }, "<leader>;", ":")

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
