return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"jbyuki/one-small-step-for-vimkind",
	},
	lazy = false,
	keys = function()
		local widgets = require("dap.ui.widgets")
		local dap = require("dap")
		local M = {
			{ "<leader>db", dap.toggle_breakpoint, { noremap = true } },
			{ "<leader>dc", dap.continue, { noremap = true } },
			{ "<leader>do", dap.step_over, { noremap = true } },
			{ "<leader>di", dap.step_into, { noremap = true } },
			{
				"<leader>dl",
				function()
					require("osv").launch({ port = 8086 })
				end,
				{ noremap = true },
			},
			{
				"<leader>dw",
				function()
					widgets.hover()
				end,
			},
			{
				"<leader>df",
				function()
					widgets.centered_float(widgets.frames)
				end,
			},
		}
		return M
	end,
	config = function()
		local dap = require("dap")
		dap.configurations.lua = {
			{
				type = "nlua",
				request = "attach",
				name = "Attach to running Neovim instance",
			},
		}

		dap.adapters.nlua = function(callback, config)
			callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
		end
	end,
}
