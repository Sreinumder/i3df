return {
	"chrisgrieser/nvim-genghis",
	version = "*",
	dependencies = { "stevearc/dressing.nvim" },
	keys = {
		{
			"<leader>eya",
			function()
				require("genghis").copyFilepathWithTilde()
			end,
			desc = "genghis: Absolute path",
		},
		{
			"<leader>eyr",
			function()
				require("genghis").copyRelativePath()
			end,
			desc = "genghis: Relative path",
		},
		{
			"<leader>eyn",
			function()
				require("genghis").copyFilename()
			end,
			desc = "genghis: Name of file",
		},
		{
			"<leader>eyp",
			function()
				require("genghis").copyDirectoryPath()
			end,
			desc = "genghis: Parent path",
		},
		{
			"<leader>er",
			function()
				require("genghis").renameFile()
			end,
			 desc = "genghis: renameFile" ,
		},
		{
			"<leader>em",
			function()
				require("genghis").moveAndRenameFile()
			end,
			 desc = "genghis: moveAndRenameFile" ,
		},
		{
			"<leader>ec",
			function()
				require("genghis").moveToFolderInCwd()
			end,
			 desc = "genghis: moveToFolderInCwd" ,
		},
		{
			"<leader>en",
			function()
				require("genghis").createNewFile()
			end,
			 desc = "genghis: createNewFile" ,
		},
		{
			"<leader>gm",
			function()
				require("genghis").duplicateFile()
			end,
			 desc = "genghis: duplicateFile" ,
		},
		{
			"<leader>edf",
			function()
				require("genghis").trashFile()
			end,
			 desc = "genghis: trashFile" ,
		},
		{
			"<leader>em",
			mode = { "x" },
			function()
				require("genghis").moveSelectionToNewFile()
			end,
			 desc = "genghis: move selection to new file" ,
		},
		{
			"<leader>ex",
			function()
				require("genghis").chmodx()
			end,
			 desc = "genghis: chmodx" ,
		},
	},
}
