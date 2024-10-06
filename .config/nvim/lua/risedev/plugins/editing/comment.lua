--┌───────────────────┐
--│Line gcc Block  gbc│
--│End of line     gcA│
--│Line Above      gcO│
--│Line below      gco│
--└───────────────────┘

return {
	"numToStr/Comment.nvim",
	-- event = { "BufReadPre", "BufNewFile" },
	keys = {
    { "gc", mode = { "v", "n" } },
    { "gb", mode = { "v", "n" } },
    -- {'<C-/>', function() require('Comment.api').toggle.linewise.current() end, mode = {"n", "i"}},
    {'<C-/>', function() vim.api.nvim_feedkeys('<esc>', 'nx', false)
      require('Comment.api').toggle.linewise(vim.fn.visualmode()) end, mode = {'x'}},
    -- {'<c-/>', function()
    --     require('Comment.api').call('toggle.linewise.current', 'g@$')
    -- end, { expr = true }, mode={"v", "n"}},
  },
	opts = {
      -- [[ toggler = { line ={'<C-/>', 'gcc'}, block = 'gbc' }, ]]
  },
	config = true,
	lazy = true,
}
