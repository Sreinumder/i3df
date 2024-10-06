--┌───────────┬──────────┬─────────────┬──────────────────────┐
--│ Old text  │ Command  │new text     │        usage         │
--├───────────┼──────────┼─────────────┼──────────────────────┤
--│ surround  │ ysiw)    │(surround)   │ inner word           │
--│ "lol"     │ ysa"}    │{"lol"}      │ adds new sding       │
--│ hel*lo    │ yss"     │ "hello"     │ entire line          │
--│ "camera"  │ ds"      │ camera      │ deletes sding        │
--│ 'quote'   │ cs'"     │"quote"      │ changes ' sd to "    │
--│ <b>tag</b>│ dst      │tags         │ deletes sding tag    │
--│ <b>tag</b>│ csth1<CR>│<h1>tag</h1> │ changes tag          │t for tag
--│ visualmode│ viwS"    │"visualmode" │ S for sding selection│
--│ string    │ ys$"     │"strings"    │                      │
--│ arg*s     │ ysiwffn  │ fn(args)    │ create a fn with arg │f for fn
--│ fn(a, b)  │ dsf      │ a, b        │ deletes fn name      │
--│ fn(a, b)  │ csfnew   │ n(a, b)     │ changes fn name      │
--└───────────┴──────────┴─────────────┴──────────────────────┘
-- note: '(' surrounds with ( space )
--       ')' surrounds without (space)
return {
	"kylechui/nvim-surround",
	version = "*",
	event = "BufEnter",
	opts = {},
}

-- ys surround
-- l=letter iw=inside word aw=around word
-- "asfj"

-- ysiw", ysa"), ysl', yst;'
-- ds) ds'
-- cs)' cs'"

-- yss" for whole sentence
-- 'hello world'
-- i mod <C-g>s(
-- v mod S'
