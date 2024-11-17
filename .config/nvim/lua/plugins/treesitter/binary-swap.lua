return {
  'Wansmer/binary-swap.nvim',
  keys ={
    {'g<leader>h', function () require('binary-swap').swap_operands() end, {desc = "swap without operand"}},
    {'g<leader>l', function () require('binary-swap').swap_operands_with_operator() end, {desc = "binary swap"}},
  }
}
