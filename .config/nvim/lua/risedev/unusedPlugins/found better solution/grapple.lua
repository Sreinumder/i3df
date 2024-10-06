return {
	"cbochs/grapple.nvim",
	opts = {
		scope = "git", -- also try out "git_branch"
	},
	-- event = { "BufReadPost", "BufNewFile" },
	cmd = "Grapple",
	keys = {
		{ "<leader>gg", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
		{ "<leader>gh", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
		{ "<leader>gj", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple cycle next tag" },
		{ "<leader>gk", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple cycle previous tag" },
		{ "<leader>ga", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
		{ "<leader>gs", "<cmd>Grapple select index=2<cr>", desc = "Select first tag" },
		{ "<leader>gd", "<cmd>Grapple select index=3<cr>", desc = "Select first tag" },
		{ "<leader>gf", "<cmd>Grapple select index=4<cr>", desc = "Select first tag" },
	},
}
