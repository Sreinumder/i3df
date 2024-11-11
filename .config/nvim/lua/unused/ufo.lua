return {
  'kevinhwang91/nvim-ufo',
  dependencies = {'kevinhwang91/promise-async'},
  lazy = false,
  config = function()
    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    require('ufo').setup()
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
    vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith)
    -- vim.keymap.set('n', 'zr', require('ufo').openFoldsWith)
    -- vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
    local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
    for _, ls in ipairs(language_servers) do
      require('lspconfig')[ls].setup({
        capabilities = capabilities
        -- you can add other fields for setting up lsp server in this table
      })
    end
  end,
}
