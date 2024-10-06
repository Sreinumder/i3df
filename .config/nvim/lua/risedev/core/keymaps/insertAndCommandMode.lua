vim.g.mapleader = " "
local keymap = vim.keymap -- for conciseness

keymap.set("i", "<c-u>", "<Esc>viw~ea", {desc="toggle case"})
keymap.set("i", "<c-t>", "<Esc>b~lea", {desc="change word case to title"})
keymap.set("i", "<C-l>", '<C-r>=expand("%:p:h") . "/" <CR>', {desc = "write file path"})

keymap.set({ "i", "c", "t"}, "<A-h>", "<Left>", { desc = "Insert mode left" })
keymap.set({ "i", "c", "t"}, "<A-j>", "<Down>", { desc = "Insert mode down" })
keymap.set({ "i", "c", "t"}, "<A-k>", "<Up>", { desc = "Insert mode up" })
keymap.set({ "i", "c", "t"}, "<A-l>", "<Right>", { desc = "Insert mode Right" })

keymap.set("i", "<A-H>", "<C-Left>", { desc = "Insert mode left" })
keymap.set("i", "<A-J>", "<C-Down>", { desc = "Insert mode down" })
keymap.set("i", "<A-K>", "<C-Up>", { desc = "Insert mode up" })
keymap.set("i", "<A-L>", "<C-Right>", { desc = "Insert mode Right" })

keymap.set("i", "<A-n>", "<esc>wwct,", { desc = "change next csv" })
keymap.set("i", "<A-N>", "<esc>bbcT, ", { desc = "change inside next csv surrounded by ?" })

-- Go to the beginning and end of current line in insert mode quickly
keymap.set({ "i", "c" }, "<C-A>", "<HOME>")
keymap.set({ "i", "c" }, "<C-E>", "<END>")
keymap.set("c", "<C-A-K>", "\\(.*\\)", {desc="kirby "})
-- lmao useful but weird ass key bind for sort shuf and many more to filter from a list like a, b, c, d, e, f
keymap.set("x", "<A-o>", '<esc>a<Enter><esc>gvo<esc>i<Enter><esc>^"_d0vg_!sed "s/, */\\n/g"| grep -v "^$" |  | sed -z "s/\\n/, /g"<C-Left><C-Left><C-Left><C-Left><C-Left><C-Left>')
keymap.set("x", "<leader>oso", '<esc>a<Enter><esc>gvo<esc>i<Enter><esc>^"_d0vg_!sed "s/, */\\n/g"| grep -v "^$" | sort -g | sed -z "s/\\n/, /g"<CR>kJxJhx')
keymap.set("x", "<leader>osr", '<esc>a<Enter><esc>gvo<esc>i<Enter><esc>^"_d0vg_!sed "s/, */\\n/g"| grep -v "^$" | sort -gr | sed -z "s/\\n/, /g"<CR>kJxJhx')
keymap.set("x", "<leader>oss", '<esc>a<Enter><esc>gvo<esc>i<Enter><esc>^"_d0vg_!sed "s/, */\\n/g"| grep -v "^$" | shuf | sed -z "s/\\n/, /g"<CR>kJxJhx')
keymap.set("x", "<leader>on", '<esc>a<Enter><esc>gvo<esc>i<Enter><esc>^"_d0vg_!sed "s/, */\\n/g"| grep -v "^$" | wc -l<CR>kJxJhx')

-- {e, a, b, d, c, f, }
-- {a, b, c, d, e, f, }
-- shuf -i 1-10 -n 10 -r  | sed -z "s/\\n/, /g"
-- keymap.set("n", "<leader>vrl", 'i<enter><esc>!!shuf -i 1-10 -n 10 -r  | sed -z "s/\\n/, /g"<CR>kgJ')
keymap.set("n", "<A-o>", 'i<enter><enter><Up><esc>!! | sed -z "s/\\n/, /g"<Home><Right><Right>', {desc = "genearate comma seperated seq or shuf or any bash output"})
keymap.set("i", "<A-o>", '<enter><enter><Up><esc>!! | sed -z "s/\\n/, /g"<Home><Right><Right>', {desc = "genearate comma seperated seq or shuf or any bash output"})

-- generating 10 random 

-- keymap.set("c", "<A-S-\'>", "\"\"<Left>")
-- keymap.set("c", "<A-\">", "\'\'<Left>")
-- keymap.set("c", "<A-S-,>", "<><Left>")
-- keymap.set("c", "<A-S-9>", "()<Left>")
-- CTRL-O h  move cursor left CTRL-O l  move cursor right
-- CTRL-O j  move cursor down
-- CTRL-O k  move cursor up
-- CTRL-W    delete word to the left of cursor
-- CTRL-O D  delete everything tohh the right of cursor
-- CTRL-U    delete everything to the left of cursor
-- CTRL-H    backspace/delete
-- CTRL-J    insert newline (easier than reaching for the return key
-- CTRL-T    indent current line
-- CTRL-D    un-indent current line
