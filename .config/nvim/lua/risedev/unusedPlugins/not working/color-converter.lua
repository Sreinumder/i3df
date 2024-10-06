return {
    'NTBBloodbath/color-converter.nvim',
    Event = { BufEnter},
    config = function()
        -- require('color-converter')
        -- vim.keymap.set('n', "<leader>jcc", ':colorConvertCycle', {desc = "cycle hsl rgb hex"})
        -- vim.keymap.set("n", "<leader>jcc", function() require("color-converter").colorConvertCycle('RGB') end,{desc = "cycle hsl rgb hex"})
        -- vim.keymap.set("n", "<leader>jcc", <Plug>ColorConvertCycle,{desc = "cycle hsl rgb hex"})
        -- vim.keymap.set("n", 'n',"<leader>jcc", function() vim.cmd("<Plug>ColorConvertCycle") end, { desc = "cycle hsl rgb hex" })
        vim.keymap.set("n", 'n',"<leader>jcc", ':lua require('color-converter').cycle()<CR>', { desc = "cycle hsl rgb hex" })

    end,
}
-- #3333f3
