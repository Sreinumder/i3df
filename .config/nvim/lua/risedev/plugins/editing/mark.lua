return {
	"chentoast/marks.nvim",
	-- event = "BufEnter",
  keys = {
    {"m", mode = {"n", "x"}},
    {"dm", mode = {"n", "x"}},
  },
	opts = {
		mappings = {
			toggle = "m<leader>",
			annotate = "mma", -- annotates bookmark
			set_next = "mm<leader>",
			set_bookmark0 = "m0", -- m0,m1,...
			prev = "mk",
			next = "mj",
			prev_bookmark = "m,k",
			next_bookmark = "m,j",
			delete_bookmark = "dmm",
			delete_line = "dmm",
			delete_buf = "dmb",
			preview = "m;",
		},
	},
	-- config = function()
	-- 	require("marks").setup(opts)
	-- 	local marks_fix_group = vim.api.nvim_create_augroup("marks-fix-hl", {})
	-- 	vim.api.nvim_create_autocmd({ "VimEnter" }, {
	-- 		group = marks_fix_group,
	-- 		callback = function()
	-- 			vim.api.nvim_set_hl(0, "MarkSignNumHL", {})
	-- 		end,
	-- 	})
	-- end,
}
