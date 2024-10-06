return {
	"echasnovski/mini.cursorword",
	version = "*",
	-- event = "CursorMoved",
  keys = {
    {"<leader>,cw",
    function()
      if vim.g.minicursorword_disable then
        vim.g.minicursorword_disable = false
      else
        vim.g.minicursorword_disable = true
     end
   end, desc="toggle mini.cursorword"}
  },
  opts = {},
}
-- mini
