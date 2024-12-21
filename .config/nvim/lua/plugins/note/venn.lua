-- ┌──────────────────────────────────────┐
-- │ toggle diagram mode with :VBox       │
-- │ draw a box with f                    │
-- │ HJKL for line drawing                │
-- └──────────────────────────────────────┘
--  ┌─────────────────────────────────┐
--  │┌────────┐                ┌─────┐│
--  ││creating├──────────────► │those││
--  │└────────┘        ┌────┐  └──┬──┘│
--  │  ▲  ▲    ┌──┐  ┌─┤this│     │   │
--  │  │  └────┤is│◄─┘ └────┘     │   │
--  │  │       └──┘               ▼   │
--  │  │ ┌────┐            ┌────────┐ │
--  │  └─┤lmao│ ◄──────────┤ boxes  │ │
--  │    └────┘            └────────┘ │
--  └─────────────────────────────────┘
return {
	"jbyuki/venn.nvim",
	dependencies = {
		"smoka7/hydra.nvim",
	},
	keys = {
		{mode={"n", "v"}, "<leader>,v" },
	},
	config = function()
		local Hydra = require("hydra")
		local hint = [[
     Arrow^^^^^^   Select region with <C-v> 
     ^ ^ _K_ ^ ^   _f_: surround it with box
     _H_ ^ ^ _L_
     ^ ^ _J_ ^ ^                      _<Esc>_
    ]]

		Hydra({
			name = "Draw Diagram",
			hint = hint,
			config = {
				color = "pink",
				invoke_on_body = true,
				hint = {
					border = "rounded",
				},
				on_enter = function()
					vim.o.virtualedit = "all"
				end,
			},
			mode = {"n", "v"},
			body = "<leader>,v",
			heads = {
				{ "H", "<C-v>h:VBox<CR>" },
				{ "J", "<C-v>j:VBox<CR>" },
				{ "K", "<C-v>k:VBox<CR>" },
				{ "L", "<C-v>l:VBox<CR>" },
				{ "f", ":VBox<CR>", { mode = "v" } },
				{ "<Esc>", nil, { exit = true } },
			},
		})
	end,
}
