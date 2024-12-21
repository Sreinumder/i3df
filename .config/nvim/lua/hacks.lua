local map = vim.keymap.set

function toggle_todo()
	local line = vim.api.nvim_get_current_line()
	local new_line

	if line:match("^%s*-%s*%[ %]") then
		-- Unchecked to checked
		new_line = line:gsub("^(%s*-%s*)%[ %]", "%1[x]")
	elseif line:match("^%s*-%s*%[x%]") then
		-- Checked to unchecked
		new_line = line:gsub("^(%s*-%s*)%[x%]", "%1[ ]")
	else
		return
	end
	vim.api.nvim_set_current_line(new_line)
end

map("n", "<leader><leader>t", toggle_todo, { noremap = true, silent = true })
map("n", "<leader>to", "o- [ ] ", { desc = "markdown todo below" })
map("n", "<leader>tO", "O- [ ] ", { desc = "markdown todo below" })
map("n", "<leader>tc", "cc- [ ] ", { desc = "markdown todo change" })

map("n", "<leader>eo", function()
	local file_path = vim.fn.expand("%:p")
	if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
		vim.fn.jobstart({ "explorer", "/select,", file_path }, { detach = true })
	else
		vim.fn.jobstart({ "thunar", file_path }, { detach = true })
	end
end, { desc = "Open current file in file manager" })

map("n", "<A-.>", ":<Up><CR>", { desc = "last command" })
map("n", "g<leader>gx", '"gya":lua vim.ui.open("https://www.github.com/"..<C-r>g)<CR>', { desc = "open in github" })

-- bash hack for sorting/shuffling/sequencing csv with <A-o> in normal or insert mode
-- map( "<leader>vrl", /g"<CR>kgJ', "n", 'i<enter><esc>!!shuf -i 1-10 -n 10 -r  | sed -z "s/\\n/, )
map(
	"n",
	"<A-o>",
	'i<enter><enter><Up><esc>!! | sed -z "s/\\n/, /g"<Home><Right><Right>',
	{ desc = "genearate comma seperated seq or shuf or any bash output" }
)
map(
	"i",
	"<A-o>",
	'<enter><enter><Up><esc>!! | sed -z "s/\\n/, /g"<Home><Right><Right>',
	{ desc = "genearate comma seperated seq or shuf or any bash output" }
)
map(
	"x",
	"<A-o>",
	'<esc>a<Enter><esc>gvo<esc>i<Enter><esc>^"_d0vg_!sed "s/, */\\n/g"| grep -v "^$" |  | sed -z "s/\\n/, /g"<C-Left><C-Left><C-Left><C-Left><C-Left><C-Left>'
)

map(
	"x",
	"<leader>oso",
	'<esc>a<Enter><esc>gvo<esc>i<Enter><esc>^"_d0vg_!sed "s/, */\\n/g"| grep -v "^$" | sort -g | sed -z "s/\\n/, /g"<CR>kJxJhxgv'
)
map(
	"x",
	"<leader>osr",
	'<esc>a<Enter><esc>gvo<esc>i<Enter><esc>^"_d0vg_!sed "s/, */\\n/g"| grep -v "^$" | sort -gr | sed -z "s/\\n/, /g"<CR>kJxJhxgv'
)
map(
	"x",
	"<leader>oss",
	'<esc>a<Enter><esc>gvo<esc>i<Enter><esc>^"_d0vg_!sed "s/, */\\n/g"| grep -v "^$" | shuf | sed -z "s/\\n/, /g"<CR>kJxJhxgv'
)
map(
	"x",
	"<leader>on",
	'<esc>a<Enter><esc>gvo<esc>i<Enter><esc>^"_d0vg_!sed "s/, */\\n/g"| grep -v "^$" | wc -l<CR>kJxJhx'
)

-- https://aur.archlinux.org/packages/python-translate-shell
-- map("n", "<leader>ttt", "^vg_\"ty:vnew <CR>:.!trans <C-r>t | sed 's/\\x1b\\[[0-9;]*m//g'<CR>", { desc = "translate autodetect -> en" })
-- map("n", "<leader>ttd", "viw\"ty:vnew <CR>:.!trans -d <C-r>t | sed 's/\\x1b\\[[0-9;]*m//g'<CR>", { desc = "dictionary autodetect -> en" })
map(
	"n",
	"<leader>ttt",
	"^vg_\"ty:vnew <CR>:.!trans '<C-r>t' | sed 's/\\x1b\\[[0-9;]*m//g'<Home><C-Right> -t en",
	{ desc = "dictionary autodetect -> ??" }
)
map(
	"n",
	"<leader>ttd",
	"viw\"ty:vnew <CR>:.!trans -d <C-r>t | sed 's/\\x1b\\[[0-9;]*m//g'<Home><C-Right> -t en",
	{ desc = "dictionary autodetect -> ??" }
)
map(
	"x",
	"<leader>ttt",
	"\"ty:vnew <CR>:.!trans '<C-r>t' | sed 's/\\x1b\\[[0-9;]*m//g'<Home><C-Right> -t en",
	{ desc = "translate autodetect -> ??" }
)
map(
	"x",
	"<leader>ttd",
	"\"ty:vnew <CR>:.!trans -d <C-r>t | sed 's/\\x1b\\[[0-9;]*m//g'<Home><C-Right> -t en",
	{ desc = "dictionary autodetect -> ??" }
)

-- bash filter trans
map("n", "<leader>rt", '"tyy"tp"tp0d}k!!trans -t  -b<C-Left><Left>', { desc = "translate filter append" })
map("n", "<leader>rs", '"byy"bp"bp0d}k!!sh<cr>', { desc = "bash filter append" })
map("n", "<leader>rS", "!!sh<cr>", { desc = "bash filter replace" })

-- niche visual selection hacks
map("x", "<A-x>", '<esc>"_x`<"_xv`>h', { desc = "delete surrounding of visual mode" })
map("x", "<A-c>", '"bdo<esc>"bpk"_dd', { desc = "delete except the selection of current line" })

-- -- increase/decrease and shift visual selection
-- map("x", "<C-l>", "loho", { desc = "change vi range" })
-- map("x", "<C-h>", "holo", { desc = "change vi range" })
-- map("x", "<C-j>", "joko", { desc = "change vi range" })
-- map("x", "<C-k>", "kojo", { desc = "change vi range" })
-- map("x", "<C-S-l>", "lolo", { desc = "shift vi range" })
-- map("x", "<C-S-h>", "hoho", { desc = "shift vi range" })
-- map("x", "<C-S-j>", "jojo", { desc = "shift vi range" })
-- map("x", "<C-S-k>", "koko", { desc = "shift vi range" })

-- -- Comment
map("n", "<C-/>", "gcc", { desc = "toggle comment", remap = true })
map("v", "<C-/>", "gc", { desc = "toggle comment", remap = true })

-- comment and clone sentence
map("v", "<leader><C-/>", '"cyygcc"cp', { desc = "toggle comment", remap = true })
