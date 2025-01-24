-- https://github.com/echasnovski/mini.jump
return {
	"echasnovski/mini.jump",
	opts = {
		mappings = {
			forward = "<A-n>",
			backward = "<A-N",
			-- forward_till = "<A-N>",
			-- backward_till = "<A-N>",
			-- repeat_jump = ";",
		},

		-- Delay values (in ms) for different functionalities. Set any of them to
		-- a very big number (like 10^7) to virtually disable.
		delay = {
			-- Delay between jump and highlighting all possible jumps
			highlight = 250,

			-- Delay between jump and automatic stop if idle (no jump is done)
			idle_stop = 10000000,
		},

		-- Whether to disable showing non-error feedback
		-- This also affects (purely informational) helper messages shown after
		-- idle time if user input is required.
		silent = false,
	},
}
