-- ┌─────────────────────────────────┐
-- │   jumps to the file at last     │
-- │   place when saved              │
-- └─────────────────────────────────┘
return {
	"ethanholz/nvim-lastplace",
	events = { "BufEnter" },
	config = function()
		require("nvim-lastplace").setup()
	end,
}
