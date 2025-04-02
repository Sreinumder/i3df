return {
	"echasnovski/mini.operators",
	dependencies = { "echasnovski/mini.ai" },
  -- event = "UIEnter",
	keys = {
		{ modes = { "n", "x" }, "s", desc = "Substitute Operator" },
		{ modes = { "n", "x" }, "gm", desc = "Multiply Operator" },
		{ modes = { "n", "x" }, "<A-s>", desc = "Exchange Operator" },
		{ modes = { "n", "x" }, "g=", desc = "Evaluate Operator" },
		-- pain points solved
		{ "<A-s><A-s>", "V<A-s>", desc = "Exchange Operator line-wise", remap = true },
		{ "S", "s$", desc = "Substitute to EoL", remap = true },
		{ "gmM", "gm$", desc = "Multiply to EoL", remap = true },
		{ "<A-S>", "<A-s>$", desc = "Exchange to EoL", remap = true },
		{ "<leader>gh", "<A-s>ia<A-s>ila", desc = "Exchange arg", remap = true },
		{ "<leader>gl", "<A-s>ia<A-s>ina", desc = "Exchange arg", remap = true },
	},
	version = "*",
	opts = {
    replace = { prefix = "s" },
    multiply = { prefix = "gm" },
		exchange = { prefix = "<A-s>" },
    evaluate = { prefix = "g=" },
		sort = { prefix = "" },
	},
}
