return {
	"chrisgrieser/nvim-genghis",
	version = "*",
	dependencies = { "stevearc/dressing.nvim" },
	keys = {
		{
			"<leader>ya",
			function()
				require("genghis").copyFilepathWithTilde()
			end,
			desc = "󰝰 Absolute path",
		},
		{
			"<leader>yr",
			function()
				require("genghis").copyRelativePath()
			end,
			desc = "󰝰 Relative path",
		},
		{
			"<leader>yn",
			function()
				require("genghis").copyFilename()
			end,
			desc = "󰈔 Name of file",
		},
		{
			"<leader>yp",
			function()
				require("genghis").copyDirectoryPath()
			end,
			desc = "󰝰 Parent path",
		},
		{
			"<leader>er",
			function()
				require("genghis").renameFile()
			end,
			{ desc = "renameFile" },
		},
		{
			"<leader>em",
			function()
				require("genghis").moveAndRenameFile()
			end,
			{ desc = "moveAndRenameFile" },
		},
		{
			"<leader>ec",
			function()
				require("genghis").moveToFolderInCwd()
			end,
			{ desc = "moveToFolderInCwd" },
		},
		{
			"<leader>en",
			function()
				require("genghis").createNewFile()
			end,
			{ desc = "createNewFile" },
		},
		{
			"<leader>ey",
			function()
				require("genghis").duplicateFile()
			end,
			{ desc = "duplicateFile" },
		},
		{
			"<leader>edf",
			function()
				require("genghis").trashFile()
			end,
			{ desc = "trashFile" },
		},
		{
			"<leader>em",
			mode = { "x" },
			function()
				require("genghis").moveSelectionToNewFile()
			end,
			{ desc = " move selection to new file" },
		},
		{
			"<leader>ex",
			function()
				require("genghis").chmodx()
			end,
			{ desc = "chmodx" },
		},
	},
}
