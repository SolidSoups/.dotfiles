local mason_lspconfig = require("mason-lspconfig")

-- Add nvim-cmp LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if has_cmp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- Configure lua_ls with special settings
vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    }
  }
})

-- Configure other LSP servers with nvim-cmp capabilities
vim.lsp.config('*', {
  capabilities = capabilities,
})

-- Setup mason-lspconfig with automatic_enable (v2.0.0+)
mason_lspconfig.setup({
  ensure_installed = { 'lua_ls', 'tailwindcss', 'clangd', 'cmake' },
  automatic_installation = true,
  automatic_enable = true,  -- Replaces setup_handlers()
})
