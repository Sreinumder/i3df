local keymap = vim.keymap -- for conciseness
keymap.set("n", "<leader>", "<NOP>", { desc = "Lazy nvim" })


keymap.set("n", "<leader>L", ":Lazy<CR>", { desc = "Lazy nvim" })
keymap.set("n", "<A-v>", "vlh", { desc = "vi single char under cursor" })

if not vim.g.os then
    local is_windows = vim.fn.has("win64") or vim.fn.has("win32") or vim.fn.has("win16")
    if is_windows then
        vim.g.os = "Windows"
        keymap.set("n", "<leader>v", "<C-v>", { desc = "vi for windows" })
    end
end

vim.keymap.set("x", "J", "j")

keymap.set({ "n", "x" }, "j", "gj", { desc = "next text wrapped line" })
keymap.set({ "n", "x" }, "k", "gk", { desc = "prev text wrapped line" })
keymap.set({ "n", "x" }, "gj", "j", { desc = "next line" })
keymap.set({ "n", "x" }, "gk", "k", { desc = "prev line" })

keymap.set({ "n", "v", "o" }, "H", "^", { desc = "Start of line" })
-- keymap.set({ "n", "v", "o" }, "<A-M>", "gM", { desc = "Middle of Line" })
keymap.set({ "n", "v", "o" }, "L", "g_", { desc = "End of Line" }) -- Do not include white space characters when using $ in visual mode, see https://vi.stackexchange.com/q/12607/15292
keymap.set("x", "$", "g_")
keymap.set("x", "g_", "$")
keymap.set("n", "<A-H>", "H", { desc = "Default H" })
keymap.set("n", "<A-L>", "L", { desc = "Default L" })

-- keymap.set({ "n", "v", "o" }, "K", "H", { desc = "Highest line of screen" })
-- keymap.set({ "n", "v", "o" }, "J", "L", { desc = "Lowest line of screen" })

keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
-- keymap.set("n", "<C-o>", "<C-o>zz", { desc = "center on <c-o>" })
-- keymap.set("n", "<C-i>", "<C-i>zz", { desc = "center on <c-i>" })

-- keymap.set({'n','v'}, "<CR>", "A<CR><ESC>", {desc = ""})
-- keymap.set({'n','v'}, "<S-CR>", "I<CR><ESC>", {desc = ""})

-- Continuous visual shifting (does not exit Visual mode), `gv` means
-- to reselect previous visual area, see https://superuser.com/q/310417/736190
keymap.set("x", "<", "<gv")
keymap.set("x", ">", ">gv")

keymap.set("n", "<leader>rs", '"byy"bp"bp0d}k!!sh<cr>', {desc = "filter the line with bash"})
keymap.set("n", "<leader><leader>rs", '0"by$0j"_d}"bp!!sh<cr>mb}O<esc>`b', {desc = "filter the line with bash"})
keymap.set("n", "<leader>rS", "!!sh<cr>", {desc = "filter the line with bash"})

-- keymap.set("n", "<leader>sv", function() vim.cmd([[ update $MYVIMRC source $MYVIMRC ]])
keymap.set("n", "<leader>sv", function() vim.cmd(" update source $MYVIMRC ") end, {desc = "source the config"})

-- 	vim.notify("Nvim config successfully reloaded!", vim.log.levels.INFO, { title = "nvim-config" })
-- end, {
-- 	silent = true,
-- 	desc = "reload init.lua",
-- })

-- Always use very magic mode for searching
-- keymap.set("n", "/", [[/\v]])

-- Use Esc to quit builtin terminal
keymap.set("t", "<Esc>", [[<c-\><c-n>]])

-- check the syntax group of current cursor position
-- keymap.set("n", "<leader>st", "<cmd>call utils#SynGroup()<cr>", { desc = "check syntax group" })
