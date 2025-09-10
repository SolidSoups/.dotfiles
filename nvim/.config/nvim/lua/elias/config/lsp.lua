vim.lsp.enable({
  'lua_ls',
  'tailwindcss',
  'clangd',
  'cmake',
})


vim.lsp.set_log_level("INFO")
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- completion
    if client:supports_method('textDocument/completion') then
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup', 'preview' }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true, })
      vim.keymap.set("i", "<C-Space>", function()
        vim.lsp.completion.get()
      end)
    end

    -- type definition
    if client:supports_method('textDocument/typeDefinition') then
      vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, {
        buffer = ev.buf,
        desc = "LSP Goto type definition",
      })
    end

    -- definition support
    if client:supports_method('textDocument/definition') then
      vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, {
        desc = "LSP Goto definition",
      })
    end

    -- implementation support
    if client:supports_method('textDocument/implementation') then
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {
        desc = "LSP Goto implementation",
      })
    end

    -- declaration support
    if client:supports_method('textDocument/declaration') then
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
        desc = "LSP Goto declaration",
      })
    end

    -- formatting
    if client:supports_method('textDocument/formatting') then
      vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, {
        buffer = ev.buf,
        desc = "LSP Language Format",
      })
    end
  end,
})

-- LspRestart command
vim.api.nvim_create_user_command("LspRestart", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  for _, client in ipairs(clients) do
    vim.lsp.stop_client(client.id)
  end
  vim.notify("Restarted LSP.", vim.log.levels.INFO, {})

  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)

  if filename and filename ~= "" then
    local view = vim.fn.winsaveview();
    pcall(function()
      vim.cmd('checktime')
      vim.cmd('write!')
      vim.cmd('edit!')
    end)
    vim.fn.winrestview(view);
  end
end, {})

-- LspInfo command
vim.api.nvim_create_user_command("LspInfo", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    vim.notify("No LSPs connected", vim.log.levels.INFO, {})
    return
  end
  local clients_name_list = ""
  for _, client in ipairs(clients) do
    if clients_name_list ~= "" then
      clients_name_list = clients_name_list .. ", " .. client.name
    else
      clients_name_list = client.name
    end
  end
  vim.notify("LSP Clients: " .. clients_name_list, vim.log.levels.INFO, {})
end, {})

-- keybind for lsp restart
vim.keymap.set('n', '<leader>lr', '<CMD>LspRestart<CR>')

-- Lsp Stop command
vim.api.nvim_create_user_command("LspStop", function()
  local clients = vim.lsp.get_clients({bufnr = 0})
  for _, client in ipairs(clients) do
    vim.lsp.stop_client(client.id)
  end
end, {})

-- Diagnostics
vim.opt.updatetime = 100
vim.diagnostic.config({
  update_in_insert = true,
  severity_sort = true,
  virtual_lines = {
    current_line = true,
    severity = vim.diagnostic.severity.ERROR,
  },
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  }
})

-- util

-- Keybinds
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, desc = "LSP Hover" }) --<CMD>lua vim.lsp.buf.hover()<CR>", { silent = true, noremap = true, { desc = "LSP Hover" }})
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1}) end, { desc = "LSP Hover" }) --<CMD>lua vim.lsp.buf.hover()<CR>", { silent = true, noremap = true, { desc = "LSP Hover" }})
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1}) end, { desc = "LSP Hover" }) --<CMD>lua vim.lsp.buf.hover()<CR>", { silent = true, noremap = true, { desc = "LSP Hover" }})
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show line diagnostic"})

