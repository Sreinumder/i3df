*This is using Dial.nvim and augend grouping*
<leader>+i+(character) for incrementing
<leader>+u+(character) for decrementing

cycleable:  200    B     True 01:22 2025/02/11 no  - [ ]
group:      number alpha logic time  date       word notes
character:  u      a     l     t     d          w        s

other cycleable from those groups
logic = {false or || != < -= /= --}
time = {01:01:01}
date = {June Fri}
word = mini.cycle

notes
=====
### title
- [ ] smth














## Current Workflow with dial.nvim
I currently use dial.nvim for my advanced <c-a> <c-x> needs. 
I myself like to think and group the patterns into group like alphabets, numbers, dates, time, words, logical etc.
and assign a letter for each and follow the general pattern of 
`<leader>+i+(character)` for incrementing
`<leader>+u+(character)` for decrementing

### Showcase
![dial-showcase](https://github.com/user-attachments/assets/06711676-0ece-45c3-b258-c3056019ac79)


## Feature request that are not present currently in dial.nvim

### Operator for changing next or previous pattern 
#### `<c-a>` equivalent

```
          cursor here
               V
  (x           |y           z)
   |            |           |
   v            |           v
 `<leader>ila]`    v      `[<leader>ina`
          `<leader>ia`
```

1. `<leader>ia` increments this or closest next alpha (alphabet): y->z
2. `<leader>ila` increments last alpha : x->y
3. `<leader>ina` increments next alpha : z->a

similarly, `<leader>ua` decrements this or closest next alpha.

Count Handling:
`(c)<leader>i(n)na`
increment the nth next pattern c times

example:
`2<leader>i7nu`
```
before: 1 |1 1 1  1 1 1 1  1 1 1 1
after:  1 1 1 1  1 1 1 3|  1 1 1 1
```


#### `g<c-a>` equivalent
How count is handled for:
`(c)g<leader>i(n)na`
increments every pattern until nth next pattern c times

example:
`g<leader>i7nu`
```
before: 1 |1 1 1  1 1 1 1  1 1 1 1
after:  1 2 3 4  5 6 7 8|  1 1 1 1
```

`2g<leader>i8nu`
```
before: 1 |1 1 1  1 1 1 1  1 1 1 1
after:  1 3 5 7  9 11 13 15|  1 1 1 1
```


### Operator for finding or selecting next or previous pattern
`<leader>Inu` finds and selects next number pattern
`<leader>I2na` finds and selects 2nd next alphabet pattern
`<leader>Ill` finds and selects last logical pattern
`<leader>I3ld` finds and selects 3rd last date/day pattern


#### Use it as textobject
Additonally we can now treat these cycleable patterns as an textobject.
and combine them with operators like:
`d<leader>Inu` to delete next number group pattern
`d<leader>Iu` to delete current or next number group pattern
`c<leader>Ilw` to delete next word group pattern
