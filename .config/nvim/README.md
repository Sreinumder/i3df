fjiejfieji
# Always work in progress

# Keymaps for My Config
## Summary
- hjkl for basic char movement and alt + h or alt + jkl for moving line/selection.
- H and L for jumping to start and end of line. M for middle of the lineand similarly other layers for multicursor, cloning, treesitter jump to next/prev, child/parent node.
- alt + d for cutting d for deleting. similarly, c and alt + c.
- \< and \> for syncing vim and clipboard register
- To paste from clipboard, press < and then [p]aste.
- To copy to clipboard, first cop[y] the thing then press >

- fzf-lua binds are mostly <Space>f? <Space>g? <Space>l?
- Space + ff fuzzy find files in cwd
- Space + fw ripgrep the files in cwd (search for word)
- Space + gc git commits to checkout 
- Space + ld lsp definition of the symbol under the cursor

## Layers of h j k l
I heavily used the hjkl movement keybinds for many things.
Below is the explanation

```
     k         up
   h   l  left    right
     j        down
```

| Mode           | Layer               | Description                      | Plugin                                                                   |
|----------------|---------------------|----------------------------------|--------------------------------------------------------------------------|
| normal/visual  | None                | Character-wise-move              | builtin                                                                  |
| normal/visual  | H/L                 | Non-whitespace-start/end of line | builtin                                                                  |
| normal/visual  | J/K                 | Default Join and Keywordprg      | builtin                                                                  |
| normal/visual  | alt                 | Move line                        | **[mini.move](https://github.com/echasnovski/mini.move)**                |
| visual         | Space + alt         | Move selection(new line)         | keybinding                                                               |
| normal/visual  | Shift + alt         | Clone line/selection             | keybinding                                                               |
| normal/visual  | Space + shift + alt | Clone selection(new line)        | keybinding                                                               |
| normal/visual  | ctrl                | Treesitter movement              | **[treewalker.nvim](https://github.com/aaronik/treewalker.nvim)**        |
| normal/visual  | ctrl + alt          | Add multiple cursor              | **[multicursor.nvim](https://github.com/jake-stewart/multicursor.nvim)** |
| insert/command | alt                 | Character-wise-move              | keybinding                                                               |

Since, alt h and alt l is basically indentation but more, < and > are free to map.

## Register Problem Solution
I used to use system clipboard as the default copy register.
But it makes the system clipboard all messy and filled with random lines and code snippets.
So to solve it, I am using two bindings that syncs the vim default register (\") and system clipboard register (+)
I have those mappings
```lua
map({"n", "x"}, "<", function() vim.fn.setreg('"', vim.fn.getreg('+')) end, {desc = 'clipboard to vim reg'})
map({"n", "x"}, ">", function() vim.fn.setreg('+', vim.fn.getreg('"')) end, {desc = 'vim reg to clipboard'})
```
"<" : clipboard to vim register
">" : vim register to clipboard
vim <-> clipboard

- I also didnt like how vim always replaced the content of the default register when:
    * char deleting [x]
    * [d]eleting
    * [c]hanging
    * [p]asting on visual mode
- I use '\_' black-hole register for them.
- to get default behaviour of placing the content in default register:
    * press <A-d> for cutting. Similarly, <A-x> <A-c> <A-p> for putting the content of operation on the register.

## [barbar.nvim](https://github.com/romgrk/barbar.nvim)
- Tab / Shift-Tab for switching buffer tabs
- Alt+w for closing current
- Alt+W for restoring current
- ;wh to close all in left
- ;wl to close all in right
- ;wec to close all except current

## file-explorers
### [Mini.Files](https://github.com/echasnovski/mini.files)
- Edit the file system.
- "-" for opening it in buffer directory.
- "Space+Space" for opening it in pwd.
- "Alt + hjkl " for moving forward backward up down etc.
### [Nvim-Tree](https://github.com/nvim-tree/nvim-tree.lua)
- Alt + z for toggling the tree-view
### [Yazi.nvim](https://github.com/mikavilpas/yazi.nvim)
- Alt + e for toggling the yazi floating window.


## [Arrow.nvim](https://github.com/otavioschwanck/arrow.nvim)
- "," for jumping/pinning files.
- "m" for jumping/pinning lines.

## [FZF-lua](https://github.com/ibhagwan/fzf-lua)
### General
| keystroke | description               | keystroke      | description                |
|-----------|---------------------------|----------------|----------------------------|
| space+fa  | [a]rgs                    | space+fo       | [o]ldfiles                 |
| space+fb  | [b]uffers                 | space+fp       | [p]lugins (local)          |
| space+fc  | [c]ommit (current-buffer) | space+fq       | [q]uickfix                 |
| space+fd  | [d]irectory zoxide        | space+fQ       | [Q]uickfix Stack           |
| space+ff  | [f]iles                   | space+fr       | [r]egisters                |
| space+fh  | [h]elp tag,               | space+ft       | [t]reesitter               |
| space+fk  | [k]eymaps                 | space+fT       | [T]reesitter jump (Custom) |
| space+fl  | [l]ine                    | space+fw       | [w]ord                     |
| space+fM  | [M]anpages                | space+f?       | [?]builtin fzf-options     |
| space+fm  | [m]arks,                  | space+f+Ctrl+o | [Ctrl+o] jumplist          |
| space+fn  | [n]otes                   | space+f:       | [:] commands history       |
| space+f/  | [/] search history,       | space+fz=      | [z=] for spell suggest     |

### Git
| keystroke | description               | keystroke | description |
|-----------|---------------------------|-----------|-------------|
| space+gb  | git [b]ranches            | space+gt  | git [t]ags  |
| space+gc  | git [c]ommits (repo wide) | space+gS  | git [S]tash |
| space+gs  | git [s]tatus              |

### LSP
| keystroke | description                      | keystroke | description                        |
|-----------|----------------------------------|-----------|------------------------------------|
| space+lc  | [c]alls incoming                 | space+lf  | [f]inder                           |
| space+lC  | [C]alls outgoing                 | space+li  | [i]mplementations                  |
| space+lD  | [d]eclaration                    | space+lr  | [r]eferences                       |
| space+ld  | [d]efdinition                    | space+lt  | [t]ypedefs                         |
| space+le  | docum[e]nt diagonistics (buffer) | space+lx  | workspace diagonisti[x]s (project) |

## Bash things
### Filter/generate csv using bash
- <A-o> in visual mode:  select a CSV like a, c, b, d then Alt+o. pass sort as filter program.
- <A-o> in insert mode: generates CSV with shuf -r 20, seq 30 like commands
### Bash filter
- Space + rs for running current line as shell command
- try writing and in normal mode press space+rs
### Translate using trans-cli
- <leader>tr to translate current line
- <leader>td to use dictionary
- <leader>rt to translate current line and paste below.
