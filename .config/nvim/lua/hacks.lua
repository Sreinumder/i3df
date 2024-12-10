local map = vim.keymap.set

function toggle_todo()
    local line = vim.api.nvim_get_current_line()
    local new_line
    
    if line:match('^%s*-%s*%[ %]') then
        -- Unchecked to checked
        new_line = line:gsub('^(%s*-%s*)%[ %]', '%1[x]')
    elseif line:match('^%s*-%s*%[x%]') then
        -- Checked to unchecked
        new_line = line:gsub('^(%s*-%s*)%[x%]', '%1[ ]')
    else
        return
    end
    vim.api.nvim_set_current_line(new_line)
end

map('n', '<leader><leader>t', toggle_todo, { noremap = true, silent = true })
map("n", "<leader>to", "o- [ ] ", { desc = "markdown todo below" })
map("n", "<leader>tO", "O- [ ] ", { desc = "markdown todo below" })
map("n", "<leader>tc", "cc- [ ] ", { desc = "markdown todo change" })

map('n', '<leader>eo', function()
    local file_path = vim.fn.expand('%:p')
    if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
        vim.fn.jobstart({'explorer', '/select,', file_path}, {detach = true})
    else
        vim.fn.jobstart({'thunar', file_path}, {detach = true})
    end
end, { desc = 'Open current file in file manager' })
