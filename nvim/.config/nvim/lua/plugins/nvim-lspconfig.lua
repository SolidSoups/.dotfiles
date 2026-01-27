return {
  'neovim/nvim-lspconfig',
  config = function()
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          diagnostic = {
            globals = { 'vim' }
          },
          workspace = {
            library = {
              ['/usr/share/nvim/runtime'] = true,
            }
          }
        }
      }
    })
    vim.lsp.enable('clangd')
    vim.lsp.enable('lua_ls')
  end,
}
