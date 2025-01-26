--┌───────────────────────┐
--│<A-h> <A-j> <A-k> <A-l>│
--│to move lines or words │
--│in normal & visual mode│
--└───────────────────────┘
return {
    'echasnovski/mini.move',
    version = false,
    keys = {
      {"<A-h>", mode={"x", "n"}},
      {"<A-j>", mode={"x", "n"}},
      {"<A-k>", mode={"x", "n"}},
      {"<A-l>", mode={"x", "n"}},
    },
    -- config = function()
    -- Module mappings. Use `''` (empty string) to disable one.
    config = function()
        require("mini.move").setup {
            mappings = {
                -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
                left =  '<A-h>',
                right = '<A-l>',
                down =  '<A-j>',
                up =    '<A-k>',

                -- left =  '<S-left>',
                -- right = '<S-right>',
                -- down =  '<S-down>',
                -- up =    '<S-up>',

                -- Move current line in Normal mode
                line_left = '<A-h>',
                line_right = '<A-l>',
                line_down = '<A-j>',
                line_up = '<A-k>',
            },

            -- Options which control moving behavior
            options = {
                -- Automatically reindent selection during linewise vertical move
                reindent_linewise = true,
            },
        }
    end
}

