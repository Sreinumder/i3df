local keymap = vim.keymap -- for conciseness
vim.g.mapleader = " "
-- delete with x d or D and cut with alt + x + d + D
keymap.set({ "n", "v", "x" }, "x", '"_x')
keymap.set({ "n", "v", "x" }, "X", '"_X')
keymap.set({ "n", "v", "x" }, "d", '"_d')
keymap.set({ "n", "v", "x" }, "D", '"_D')
keymap.set({ "n", "v", "x" }, "c", '"_c')
keymap.set({ "n", "v", "x" }, "C", '"_C')

-- press Alt to put in register else just edit
keymap.set({ "n", "v", "x" }, "<A-x>", "x")
keymap.set({ "n", "v", "x" }, "<A-X>", "X")
keymap.set({ "n", "v", "x" }, "<A-d>", "d")
keymap.set({ "n", "v", "x" }, "<A-D>", "D")
keymap.set({ "n", "v", "x" }, "<A-c>", "c")
keymap.set({ "n", "v", "x" }, "<A-C>", "C")
keymap.set({ "n", "v", "x" }, "<A-d><A-d>", "dd")
keymap.set({ "n", "v", "x" }, "<A-c><A-c>", "cc")

-- deletes without letting the *selection* selection the contents of default register
keymap.set({ "v", "x" }, "p", '"_dP')
keymap.set({ "v", "x" }, "P", '"_dp')
keymap.set({ "v", "x" }, "<A-p>", "p")
keymap.set({ "v", "x" }, "<A-P>", "P")

-- like gv for last paste
-- keymap.set({ "n" }, "<A-g><A-v>", "`[v`]")
-- keymap.set({ "n" }, "<A-g>v>", "`[v`]")

-- Reselect the text that has just been pasted like gv, see also https://stackoverflow.com/a/4317090/6064933.
keymap.set("n", "gV", "printf('`[%s`]', getregtype()[0])", { expr = true, desc = "true" })

keymap.set("n", "<leader>p", "m`o<ESC>p``", { desc = "paste below current line(jump)" })
keymap.set("n", "<leader>P", "m`O<ESC>p``", { desc = "paste above current line(jump)" })
keymap.set("x", "<leader>dp", '"bdm`o<ESC>"bp``', { desc = "delete paste below current line(jump)" })
keymap.set("x", "<leader>dP", '"bdm`O<ESC>"bp``', { desc = "delete paste above current line(jump)" })
-- keymap.set("x", "<leader>y", '"bym`o<ESC>"bp``', { desc = "copy paste below current line(jump)" })
-- keymap.set("x", "<leader>y", '"bym`O<ESC>"bp``', { desc = "copy paste above current line(jump)" })
keymap.set("n", "<A-a>", "printf('m`%so<ESC>``', v:count1)", { expr = true, desc = "insert line below", })
keymap.set("n", "<A-i>", "printf('m`%sO<ESC>``', v:count1)", { expr = true, desc = "insert line above", })
keymap.set("x", "<A-a>", "<esc>o<esc>gv", { desc = "insert line below", })
keymap.set("x", "<A-i>", "<esc>O<esc>gv", { desc = "insert line above", })
keymap.set("n", "<A-A>", '<esc>j"_ddk', { desc = "delete the line below", })
keymap.set("n", "<A-I>", '<esc>k"_dd', { desc = "delete the line above", })

keymap.set("n", "<A-m>", "o<esc>kO<esc>j", { desc = "insert new line below and above", })
keymap.set("x", "<A-m>", "<esc>a<Enter><esc>gvo<esc>i<Enter><esc>^vg_", { desc = "insert new line below and above", })
keymap.set("n", "<A-n>", "JkJ", { desc = "join with prev and next line", })
keymap.set("x", "<A-n>", ":j<cr>^mgk$JJgv", { desc = "join with prev and next line", })
keymap.set("x", "<A-x>", '<esc>"_x`<"_xv`>h', { desc = "delete surrounding of visual mode", })
keymap.set("x", "<A-c>", '"bdo<esc>"bpk"_dd', { desc = "delete except the selection of current line", })
keymap.set("x", "<C-l>", 'loho', { desc = "increase vi range", })
keymap.set("x", "<C-h>", 'holo', { desc = "decrease vi range", })
keymap.set("x", "<C-S-l>", 'lolo', { desc = "increase vi range", })
keymap.set("x", "<C-S-h>", 'hoho', { desc = "decrease vi range", })
keymap.set("x", "<C-j>", 'joko', { desc = "increase vi range", })
keymap.set("x", "<C-k>", 'kojo', { desc = "decrease vi range", })
keymap.set("x", "<C-S-j>", 'jojo', { desc = "increase vi range", })
keymap.set("x", "<C-S-k>", 'koko', { desc = "decrease vi range", })

-- {{ rise is me }}

-- rise is the greatest neovim user
-- keymap.set("n", "<leader>jp", "o<ESC>pv'[']", { desc = "paste below current line" })
-- keymap.set("n", "<leader>jP", "O<ESC>pv'[']", { desc = "paste above current line" })

-- Copy entire buffer.
-- keymap.set("n", "<leader>ay", "<cmd>%yank<cr>", { desc = "yank entire buffer" })
-- keymap.set("n", "<leader>ad", "<cmd>%delete<cr>", { desc = "delete entire buffer" })

-- Toggle cursor column
-- keymap.set("n", "<leader>cl", "<cmd>call utils#ToggleCursorCol()<cr>", { desc = "toggle cursor column" })
