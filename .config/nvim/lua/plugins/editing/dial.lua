-- ┌────────────────────────────────┐
-- │dial up      <C-a>              │
-- │dial down    <C-x>              │
-- │月-> 水 2024/02/29 -> 2024/03/01│
-- └────────────────────────────────┘
return {
	"monaqa/dial.nvim",
	event = "BufEnter",
	-- keys = { "<leader>", mode = { "n", "x" } },
	config = function()
		local augend = require("dial.augend")
		local dial_config = require("dial.config")

		local function concat_tables(table1, table2)
			if table2 == nil then
				return table1
			end
			local result = table1 or {}
			for _, value in ipairs(table2) do
				result = concat_tables(result, value)
			end
			return result
		end

		local function AGN(Elements, Word, Cyclic)
			Word = true and Word
			Cyclic = true and Cyclic
			if Elements == nil then
				return nil
			end
			return augend.constant.new({ elements = Elements, word = Word, cyclic = Cyclic })
		end

		local augend_base = {
			-- augend.semver.alias.semver, -- versioning (v10.0.0)
			augend.hexcolor.new({ case = "lower" }),
			augend.hexcolor.new({ case = "upper" }),
		}
		dial_config.augends:register_group({
			default = augend_base,
			number = {
				augend.integer.alias.decimal_int, -- decimal number (-1, 0, 1, 2, 3, ...)
				augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
			},
			logical = {
				augend.constant.alias.bool, -- boolean value (true <-> false)
				AGN({ "True", "False" }),
				AGN({ "and", "or" }),
				AGN({ "&&", "||" }, false),
				AGN({ "==", "!=" }, false),
				AGN({ "<", ">=" }, false),
				AGN({ ">", "<=" }, false),
        AGN({ "+=", "-=" }, false),
				AGN({ "*=", "/=" }, false),
				AGN({ "++", "--" }, false),
			},
			word = {
				AGN({ "yes", "no" }),
				AGN({ "left", "right" }),
        AGN({ "up", "down" }),
				AGN({ "mini.cycle", "when" }),
				AGN({ "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth" }),
				AGN({ "First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth", "Ninth", "Tenth" }),
			},
			alpha = { augend.constant.alias.alpha, augend.constant.alias.Alpha }, -- a b c  A B C
			quote = { augend.paren.alias.quote }, -- 'rose'
			parenthesis = { augend.paren.alias.brackets },
			date = {
				augend.date.alias["%Y/%m/%d"], -- date (2024/04/23, etc.)
        augend.date.alias["%d/%m/%Y"], -- date (24/04/2024, etc.)
				-- augend.date.alias["%Y-%m-%d"], -- date (2024-04-23, etc.)
				-- augend.date.alias["%d-%m-%Y"], -- date (24-04-2024, etc.)
				-- augend.date.alias["%Y-%m-%d"], -- date (2024-04-23, etc.)
				-- augend.date.alias["%d-%m-%Y"], -- date (24-04-2024, etc.)
				augend.date.alias["%Y年%-m月%-d日(%ja)"], -- date (2024年-04月-20日, etc.)
				augend.date.alias["%Y年%-m月%-d日"],
				AGN({
					"January",
					"February",
					"March",
					"April",
					"May",
					"June",
					"July",
					"August",
					"September",
					"October",
					"November",
					"December",
				}),
				AGN({ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" }),
				augend.constant.alias.ja_weekday,
				augend.constant.alias.ja_weekday_full, -- 月 金曜日
				AGN({ "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" }),
				AGN({ "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun" }),
			},
			time = {
				augend.date.alias["%H:%M:%S"],
				augend.date.alias["%H:%M"],
			},
			notes = {
        AGN({ "- [ ]", "- [x]" }, false),
				AGN({ "=====", "-----" }, false),
				AGN({ "*", "**", "***", "****", "*****", "******", "*******" }, false),
				AGN({ "# ", "## ", "### ", "#### ", "##### ", "###### " }, false),
				-- AGN({"┘","┐","c", "└", "┌"}, false),
				-- AGN({"e","─","│"}, false),
				-- AGN({"◄", "h","►", "▼","▲"}, false),
			},
		})
		dial_config.augends:on_filetype({
			typescript = concat_tables(augend_base, { augend.constant.new({ elements = { "let", "const" } }) }),
			css,
			html = concat_tables(augend_base, { augend.integer.alias.decimal }),
			markdown = concat_tables(augend_base, { augend.misc.alias.markdown_header }),
			norg = concat_tables(augend_base, { augend.misc.alias.markdown_header }),
			org = concat_tables(augend_base, { augend.misc.alias.markdown_header }),
			json = concat_tables(augend_base, {}),
			lua = concat_tables(augend_base, {}),
			python = concat_tables(augend_base, {}),
			haskell = concat_tables(augend_base, {
				augend.constant.new({ elements = { "/=", "==" }, word = false, cyclic = true }),
			}),
		})
		local mode = { "n", "v" }
		local arga = { "increment", "decrement" }
		local argb = { "normal", "gnormal", "visual", "gvisual" }
		local group =
			{ "default", "number", "date", "time", "word", "alpha", "logical", "parenthesis", "quote", "notes" }
		local keymaps = {
			{ "<C-a>", "<C-x>", "g<C-a>", "g<C-x>" },
			-- {"<leader>ii",  "<leader>uu",  "g<leader>ii",  "g<leader>uu"},-- "default
			{ "<leader>iu", "<leader>uu", "g<leader>iu", "g<leader>uu" }, -- "number"
			{ "<leader>id", "<leader>ud", "g<leader>id", "g<leader>ud" }, -- "date",
			{ "<leader>it", "<leader>ut", "g<leader>it", "g<leader>ut" }, -- "time",
			{ "<leader>iw", "<leader>uw", "g<leader>iw", "g<leader>uw" }, -- "word",
			{ "<leader>ia", "<leader>ua", "g<leader>ia", "g<leader>ua" }, -- "alpha
			{ "<leader>il", "<leader>ul", "g<leader>il", "g<leader>ul" }, -- "logical
			{ "<leader>ip", "<leader>up", "g<leader>ip", "g<leader>up" }, -- "parenthesis
			{ "<leader>iq", "<leader>uq", "g<leader>iq", "g<leader>uq" }, -- "quote",
			{ "<leader>is", "<leader>us", "g<leader>is", "g<leader>us" }, -- "notes",
		}
		for j = 1, #group do
			for i = 0, 7 do
				-- vim.print(mode[math.floor(i/4)+1] .. " " .. keymaps[j][i%4+1] .. " " .. arga[i%2+1] .. " " .. argb[math.floor(i/2)+1] .. " " .. group[j])
				vim.keymap.set(mode[math.floor(i / 4) + 1], keymaps[j][i % 4 + 1], function()
					require("dial.map").manipulate(arga[i % 2 + 1], argb[math.floor(i / 2) + 1], group[j])
				end)
			end
		end
	end,
}
