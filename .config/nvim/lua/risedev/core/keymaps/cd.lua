vim.g.mapleader = " "
local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>cdh", ":cd ..<CR>", { desc = "cd.." })
keymap.set("n", "<leader>cdf", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "change dir" })
keymap.set("n", "<leader>cdp", "<cmd>lcd ~/.config/nvim/lua/risedev<cr>", { desc = "change dir to nvim config" })
keymap.set("n", "<leader>cdr", "<cmd>lcd ~<cr>", { desc = "change dir to ~" })
keymap.set("n", "<leader>cdn", "<cmd>lcd ~/notes<cr>", { desc = "change dir to ~" })

-- keymap.set("n", "<leader>cdh", ":cd ..", { desc = "next text wrapped line" })
-- /home/rise/.config/nvim/lua/risedev/core/keymaps
-- expand("%:p:h")
