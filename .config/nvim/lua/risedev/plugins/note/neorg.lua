return {
		"nvim-neorg/neorg",
		dependencies = { {
      "vhyrro/luarocks.nvim",
      priority = 1000,
      config = true,
    } },
		version = "*",
		ft = "norg",
		-- keys = { { "<leader>ne" } },
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {
						config = {
							-- icon_preset = "basic",
							icon_preset = "diamond",
							-- icon_preset = "varied",
							icons = {
								definition = {
									multi_prefix = { icon = "" },
									multi_suffix = { icon = "" },
									single = { icon = " 󰇼 " },
								},
								delimiter = {
									-- hrizontal_line = { icon = "󰇼 ", },
									-- strong = { icon = " ", },
									-- weak = { icon = "󰇼 ", },
								},
								-- footnote = { icons = "󰇼", },
								-- heading = { icons = { "", "󰴈", "󰌪", "", "", "" }),
								list = { icons = { "" } },
							},
						},
					},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/notes",
							},
							default_workspace = "notes",
						},
					},
				},
			})

			vim.wo.foldlevel = 99
			vim.wo.conceallevel = 2
		end,
}
