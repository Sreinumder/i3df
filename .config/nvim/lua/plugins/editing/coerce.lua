--┌─────────────────────────────────────────┐
--│changes naming convention-like camel case│
--│key bind prefix: cr in visual mode       │
--└─────────────────────────────────────────┘
return {
	"gregorias/coerce.nvim",
	-- keys = {
	-- 	{ "cr", mode = { "v", "n" } },
	-- },
  -- opts = {},
  config = function()
    require("coerce").setup()
  end,
}
