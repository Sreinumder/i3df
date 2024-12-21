-- editable quick fix list
-- return {
--   "gabrielpoca/replacer.nvim",
--   keys = {
--     {'<Leader>qf', ':lua require("replacer").run()<cr>', { silent = true, desc="editable qf" }}
--   }
-- }

return {
	"https://github.com/stevearc/quicker.nvim",
	ft = { "qf" },
	keys = {
		{ "<leader>R", function() require("quicker").refresh() end, },
	},
	init = function()
		vim.api.nvim_create_autocmd("BufReadPost", {
			pattern = "qf",
			once = true,
			callback = function()
				local refresh = require("quicker").refresh

				refresh()
				require("core.plugin").on_attach(function()
					refresh()
				end)
			end,
		})
	end,
	opts = {},
}
