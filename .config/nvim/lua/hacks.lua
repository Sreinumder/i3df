local map = vim.keymap.set

function ToggleTodo()
	local line = vim.api.nvim_get_current_line()
	local new_line
	if line:match("^%s*-%s*%[ %]") then -- Unchecked to checked
		new_line = line:gsub("^(%s*-%s*)%[ %]", "%1[x]")
	elseif line:match("^%s*-%s*%[x%]") then -- Checked to unchecked
		new_line = line:gsub("^(%s*-%s*)%[x%]", "%1[ ]")
	else
		return
	end
	vim.api.nvim_set_current_line(new_line)
end

map("n", "<localleader>tt", ToggleTodo, { noremap = true, silent = true })
map("n", "<localleader>to", "o- [ ] ", { desc = "markdown todo below" })
map("n", "<localleader>tO", "O- [ ] ", { desc = "markdown todo below" })
map("n", "<localleader>tc", "cc- [ ] ", { desc = "markdown todo change" })

map("n", "<leader>eo", function()
	local file_path = vim.fn.expand("%:p")
	if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
		vim.fn.jobstart({ "explorer", "/select,", file_path }, { detach = true })
	else
		vim.fn.jobstart({ "dolphin", "--select", file_path }, { detach = true })
	end
end, { desc = "buffer in file manager" })

if vim.fn.has("win32") ~= 0 then
  map("n", "<leader>rs", '"byy"bp"bp0d}k!!powershell<cr>', { desc = "bash filter append" })
  map("n", "<leader>rS", "!!powershell<cr>", { desc = "bash filter replace" })
else
  map("n", "<leader>rs", '"byy"bp"bp0d}k!!sh<cr>', { desc = "bash filter append" })
  map("n", "<leader>rS", "!!sh<cr>", { desc = "bash filter replace" })
end

map("n", "<leader>xx", ":lua <C-r><C-l><cr>", { desc = "lua execute" })
-- map("x", "<leader>xx", ":lua <C-r><C-l><cr>", { desc = "lua execute" })
