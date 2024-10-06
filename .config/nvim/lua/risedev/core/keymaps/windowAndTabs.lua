local keymap = vim.keymap -- for conciseness

-- window management
keymap.set("n", "<leader>w", "<C-w>", { desc = "window control" }) -- split window vertically
keymap.set("n", "<C-h>", "<C-w>h", { desc = "move left a window" }) -- split window vertically
keymap.set("n", "<C-j>", "<C-w>j", { desc = "move down a window" }) -- split window vertically
keymap.set("n", "<C-k>", "<C-w>k", { desc = "move up a window" }) -- split window vertically
keymap.set("n", "<C-l>", "<C-w>l", { desc = "move right a window" }) -- split window vertically
keymap.set("t", "<C-h>", "<cmd>wincmd h<CR>")
keymap.set("t", "<C-j>", "<cmd>wincmd j<CR>")
keymap.set("t", "<C-k>", "<cmd>wincmd k<CR>")
keymap.set("t", "<C-l>", "<cmd>wincmd l<CR>")


-- keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
-- keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
-- keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
-- keymap.set("n", "<leader>ww", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- keymap.set("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
-- keymap.set("n", "<leader>tq", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
-- keymap.set("n", "<leader>tl", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
-- keymap.set("n", "<leader>th", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- keymap.set("n", "<leader>tw", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
