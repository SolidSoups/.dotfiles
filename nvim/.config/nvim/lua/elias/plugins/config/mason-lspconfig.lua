local mason_lspconfig = require("mason-lspconfig")

-- Add nvim-cmp LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if has_cmp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- Function to try loading a custom config from lsp/ directory
local function load_custom_config(server_name)
  local ok, custom_config = pcall(require, 'lsp.' .. server_name)
  if ok then
    return custom_config
  end
  return nil
end

-- Configure other LSP servers with nvim-cmp capabilities as default
vim.lsp.config('*', {
  capabilities = capabilities,
})

-- Setup mason-lspconfig
mason_lspconfig.setup({
  ensure_installed = { 'lua_ls', 'tailwindcss', 'clangd', 'cmake' },
  automatic_installation = true,
  -- We handle server configuration manually to support custom configs
})

-- Automatically load custom configs and enable servers
local installed_servers = mason_lspconfig.get_installed_servers()
for _, server_name in ipairs(installed_servers) do
  local custom_config = load_custom_config(server_name)

  if custom_config then
    -- Merge custom config with capabilities
    local config = vim.tbl_deep_extend('force', {}, custom_config)

    -- Ensure capabilities are merged properly
    if custom_config.capabilities then
      config.capabilities = vim.tbl_deep_extend('force', capabilities, custom_config.capabilities)
    else
      config.capabilities = capabilities
    end

    vim.lsp.config(server_name, config)
  end

  -- Enable the server (custom config or default from wildcard)
  vim.lsp.enable(server_name)
end
