-- very similar to reach and grapple
return {
	"ghillb/cybu.nvim",
	branch = "main", -- timely updates
	-- branch = "v1.x", -- won't receive breaking changes
	requires = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" }, -- optional for icon support
	config = function()
		require("cybu").setup()
		local ok, cybu = pcall(require, "cybu")
		if not ok then
			return
		end
		cybu.setup()
		vim.keymap.set("n", "<C-S-k>", "<Plug>(CybuPrev)")
		vim.keymap.set("n", "<C-S-j>", "<Plug>(CybuNext)")
		-- vim.keymap.set({"n", "v"}, "<c-s-tab>", "<plug>(CybuLastusedPrev)")
		-- vim.keymap.set({"n", "v"}, "<c-tab>", "<plug>(CybuLastusedNext)")
	end,
}
