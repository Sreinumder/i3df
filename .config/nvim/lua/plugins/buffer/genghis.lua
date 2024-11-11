return {
	"chrisgrieser/nvim-genghis",
	version = "*",
	dependencies = {
    "stevearc/dressing.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-omni",
  },
	keys = {
		{ "<leader>eyp",   function() require("genghis").copyFilepath() end, { desc = "yank filepath" }, },
		{ "<leader>eyn",   function() require("genghis").copyFilename() end, { desc = "yank filename" }, },
		{ "<leader>ecx",   function() require("genghis").chmodx() end, { desc = "chmodx" }, },
		{ "<leader>er",    function() require("genghis").renameFile() end, { desc = "renameFile" }, },
		{ "<leader>emm",   function() require("genghis").moveAndRenameFile() end, { desc = "moveAndRenameFile" }, },
		{ "<leader>emc",   function() require("genghis").moveToFolderInCwd() end, { desc = "moveToFolderInCwd" }, },
		{ "<leader>en",    function() require("genghis").createNewFile() end, { desc = "createNewFile" }, },
    { "<leader>eyy",   function() require("genghis").duplicateFile() end, { desc = "duplicateFile" }, },
    { "<leader>edf",   function() require("genghis").trashFile() end, { desc = "trashFile" }, },
    { "<leader><leader>d", mode = { "x" },
      function() require("genghis").moveSelectionToNewFile() end, { desc = " move selection to new file" },
    },
  },
}
