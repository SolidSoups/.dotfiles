vim.env.PYENV_VERSION = '3.13.1'
local mason_lspconfig = require("mason-lspconfig")


-- Add nvim-cmp LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if has_cmp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- Enable snippet support (required for CSS/HTML language servers)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Function to try loading a custom config from lsp/ directory
local function load_custom_config(server_name)
  -- The lsp/ directory is at config root, not in lua/
  -- So we use dofile instead of require
  local config_path = vim.fn.stdpath('config') .. '/lsp/' .. server_name .. '.lua'
  if vim.fn.filereadable(config_path) == 1 then
    local ok, custom_config = pcall(dofile, config_path)
    if ok and custom_config then
      return custom_config
    end
  end
  return nil
end

-- Configure other LSP servers with nvim-cmp capabilities as default
vim.lsp.config('*', {
  capabilities = capabilities,
})

-- Setup mason-lspconfig
mason_lspconfig.setup({
  ensure_installed = { 'lua_ls', 'tailwindcss', 'clangd', 'cmake', 'ts_ls', 'cssls', 'html', 'bashls', 'basedpyright', 'glsl_analyzer', 'eslint', 'emmet_ls' },
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

-- Ensure clangd auto-starts on C++ files (workaround for config issue)
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  callback = function(args)
    -- Check if clangd is already attached
    local clients = vim.lsp.get_clients({ bufnr = args.buf, name = 'clangd' })
    if #clients > 0 then
      return -- Already attached
    end

    -- Load clangd config using the same function as above
    local clangd_config = load_custom_config('clangd')
    if not clangd_config then
      return -- No custom config found
    end

    -- Merge with capabilities and start
    local config = vim.tbl_deep_extend('force', { bufnr = args.buf }, clangd_config)
    config.capabilities = vim.tbl_deep_extend('force', capabilities, clangd_config.capabilities or {})

    vim.lsp.start(config)
  end,
  desc = 'Auto-start clangd for C/C++ files',
})
