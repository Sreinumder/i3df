local lazy_config = require("lazy-config")
vim.opt.shortmess:append("I")

require("options")
require("autocmd")
require("mappings")
require("hacks")
require("lazy").setup({
  { import = "plugins.editing" },
  { import = "plugins.treesitter" },
}, lazy_config)
local map = vim.keymap.set
map("n", "<leader>f", function() require("vscode").action("workbench.action.quickOpen") end, {desc = "open quickpicker"})
map("n", "<leader>j", function() require("vscode").action("workbench.action.showCommands") end, {desc = "commands"})
map("n", "<leader>k", function() require("vscode").action("workbench.action.showAllEditors") end, {desc = "tabs"})

map("n", "<A-o>", function() require("vscode").action("breadcrumbs.focusAndSelect") end, {desc = "breadcrumbs.toggle"})
map("n", ";hr", function() require("vscode").action("git.revertSelectedRanges") end, {desc = "reset range"})
map("n", ";hs", function() require("vscode").action("git.stageSelectedRanges") end, {desc = "stage range"})
map("n", ";hu", function() require("vscode").action("git.unstageSelectedRanges") end, {desc = "unstage range"})
map("n", ";hd", function() require("vscode").action("git.openChange") end, {desc = "buffer diff"})
map("n", ";ho", function() require("vscode").action("gitlens.openOnlyChangedFiles") end, {desc = "gitlens.openOnlyChangedFiles"})

map("n", "]x", function() require("vscode").action("editor.action.marker.nextInFiles") end, {desc = "mark next"})
map("n", "[x", function() require("vscode").action("editor.action.marker.prevInFiles") end, {desc = "mark prev"})

-- map("n", "<A-w>", function()
--   require("vscode").action("workbench.action.closeWindow")
-- end, {desc = "open periscope"})

-- <C-p> for workspace file picker
-- <C-S-p> for command palleke
-- <C-g> for line jumper
-- <C-S-o> for current document symbol picker
-- <C-o> for workspace document symbol picker
-- <C-S-.> or <C->> for breadcrumb focus

-- <C-K><C-R> for hunk reset
