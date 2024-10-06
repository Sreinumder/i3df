return {
	"Bekaboo/deadcolumn.nvim",
	event = "VeryLazy",
	opts = {
		-- modes = function(mode)
		-- 	return mode:find("^[ictRss\x13]") ~= nil
		-- end,
	},
  config = function()
    vim.cmd("set cc=80")
  end,
}
