return {
    "LudoPinelli/comment-box.nvim",
    config = function()
        require('comment-box').setup()
        local keymap = vim.keymap.set
        local opts = { noremap = true, silent = true }
        
        keymap({ "n", "v" }, "<Leader>cb", "<Cmd>CBccbox<CR>", opts) -- Titles
        keymap({ "n", "v" }, "<Leader>ct", "<Cmd>CBllline<CR>", opts) -- Named parts
        keymap("n", "<Leader>cl", "<Cmd>CBline<CR>", opts) -- Simple line
        keymap({ "n", "v" }, "<Leader>cm", "<Cmd>CBllbox14<CR>", opts)-- Marked comments
        -- Removing a box is simple enough with the command (CBd), but if you
        -- use it a lot:
        -- keymap({ "n", "v" }, "<Leader>cd", "<Cmd>CBd<CR>", opts)
    end,
}
