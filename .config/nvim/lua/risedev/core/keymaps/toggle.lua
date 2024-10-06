vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("n", "<leader>,nn", ":set number!<CR>", { desc = "Toggle number" })
keymap.set("n", "<leader>,nr", ":set relativenumber!<CR>", { desc = "Toggle relative number" })
keymap.set("n", "<leader>,w", ":set wrap!<CR>", { desc = "Toggle wrap" })
keymap.set("n", "<leader>,sp", ":set spell!<CR>", { desc = "Toggle spell" })
keymap.set("n", "<leader>,cl", ":set cursorline!<CR>", { desc = "Toggle cursorline" })
keymap.set("n", "<leader>,ii", ":set list!<CR>", { desc = "Toggle invisible char" })
keymap.set("n", "<leader>,ct", function()
  if vim.opt.background:get() == "dark" then
    vim.cmd ":set bg=light"
  else
    vim.cmd ":set bg=dark"
  end
end, { desc = "Toggle colorscheme bg" })
