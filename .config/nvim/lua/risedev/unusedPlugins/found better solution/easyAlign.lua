-- = Around the 1st occurrences
-- 2= Around the 2nd occurrences
-- *= Around all occurrences
-- **= Left/Right alternating alignment around all occurrences
-- <Enter> Switching between left/right/center alignment modes
return {
    'junegunn/vim-easy-align',
    config = function()
        vim.keymap.set({"n", "x"}, "<leader>ae", ":EasyAlign", {desc = "EasyAlign"})
    --     nmap ga <Plug>(EasyAlign)
    --     xmap ga <Plug>(EasyAlign)
    end,
}


-- red       = flower, rise = me
-- bluegreen = colors, lol = waht
-- pinky     = reddis, jre = ireji
