return {
	"MeanderingProgrammer/markdown.nvim",
	name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
	ft = "markdown",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		-- headings = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
		-- headings = { "󰴈 ", "󰉊 ", "󰧲 ", "󰌪 ", " ", " ", "󰲫 " },
    -- headings = { " ", " ", "󰔶 ", "󰌪 ", " ", "󰴈 " },
    headings = { "󰪥 ", " ", " ", "󰴈 ", "󰌪 ", " ", " " },
		checkbox = {
			unchecked = "󰄱 ",
			checked = " ",
		},
	},
}
