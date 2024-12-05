-- swaps operand and operator
return {
  'Wanser/binary-swap.nvim',
  keys ={
    {'g<leader>h', function () require('binary-swap').swap_operands_with_operator() end, {desc = "binary swap"}},
    {'g<leader>l', function () require('binary-swap').swap_operands() end, {desc = "swap without operand"}},
  }
}
