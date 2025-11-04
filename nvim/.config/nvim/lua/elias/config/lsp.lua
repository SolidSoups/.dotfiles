-- Mason-lspconfig setup is handled in lua/elias/plugins/init.lua
-- This ensures proper load order

vim.lsp.set_log_level("INFO")
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

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

    -- code actions
    if client:supports_method('textDocument/codeAction') then
      vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {
        buffer = ev.buf,
        desc = "LSP Code action",
      })
    end

    -- rename
    if client:supports_method('textDocument/rename') then
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {
        buffer = ev.buf,
        desc = "LSP Rename",
      })
    end

    -- references
    if client:supports_method('textDocument/references') then
      vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {
        buffer = ev.buf,
        desc = "LSP References",
      })
    end

    -- signature help
    if client:supports_method('textDocument/signatureHelp') then
      vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, {
        buffer = ev.buf,
        desc = "LSP Signature help",
      })
    end

    -- inlay hints (disabled)
    -- if client:supports_method('textDocument/inlayHint') then
    --   vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
    -- end
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

  -- Create a scratch buffer for LSP info
  local buf = vim.api.nvim_create_buf(false, true)
  local lines = {}

  table.insert(lines, "LSP Client Information")
  table.insert(lines, string.rep("=", 60))
  table.insert(lines, "")

  for _, client in ipairs(clients) do
    table.insert(lines, string.format("Server: %s (ID: %d)", client.name, client.id))
    table.insert(lines, string.rep("-", 60))

    -- Root directory
    if client.root_dir then
      table.insert(lines, string.format("  Root dir: %s", client.root_dir))
    end

    -- File types
    if client.config and client.config.filetypes then
      table.insert(lines, string.format("  Filetypes: %s", table.concat(client.config.filetypes, ", ")))
    end

    -- Command
    if client.config and client.config.cmd then
      table.insert(lines, string.format("  Command: %s", table.concat(client.config.cmd, " ")))
    end

    -- Capabilities summary
    table.insert(lines, "  Capabilities:")
    local caps = {
      { "completion", "textDocument/completion" },
      { "hover", "textDocument/hover" },
      { "signature help", "textDocument/signatureHelp" },
      { "goto definition", "textDocument/definition" },
      { "goto references", "textDocument/references" },
      { "goto implementation", "textDocument/implementation" },
      { "goto type definition", "textDocument/typeDefinition" },
      { "rename", "textDocument/rename" },
      { "code action", "textDocument/codeAction" },
      { "formatting", "textDocument/formatting" },
      { "inlay hints", "textDocument/inlayHint" },
    }

    for _, cap in ipairs(caps) do
      local supported = client:supports_method(cap[2])
      local status = supported and "✓" or "✗"
      table.insert(lines, string.format("    %s %s", status, cap[1]))
    end

    table.insert(lines, "")
  end

  table.insert(lines, string.rep("=", 60))
  table.insert(lines, "Press 'q' to close")

  -- Set buffer content
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'filetype', 'lspinfo')

  -- Open in a floating window
  local width = 70
  local height = math.min(#lines + 2, vim.o.lines - 4)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = 'minimal',
    border = 'rounded',
    title = ' LSP Info ',
    title_pos = 'center',
  })

  -- Set keymap to close with 'q'
  vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, nowait = true })
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
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, desc = "LSP Hover" })
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1}) end, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1}) end, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show line diagnostic"})

-- Symbol navigation
vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, { desc = "Document symbols" })
vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_workspace_symbols, { desc = "Workspace symbols" })

