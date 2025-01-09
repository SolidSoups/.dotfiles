require("mason-lspconfig").setup({
  ensure_installed = { "pyright", "lua_ls", "omnisharp" },
})

local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "<leader>bo", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
  vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  --vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.keymap.set("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  vim.keymap.set("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  vim.keymap.set("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  vim.keymap.set("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.keymap.set("n", "grn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.keymap.set("n", "gra", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.keymap.set("n", "grr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  vim.keymap.set("n", "<leader>ll", "<cmd>lua vim.lsp.diagnostic.setloclist()<CR>", opts)
end

local wk = require("which-key")
wk.add({
  { "gr", group = "LSP Actions"},
  { "grn",  desc = "LSP Rename" },
  { "grr",  desc = "LSP References" },
  { "gra",  desc = "LSP Code Action" },

  { "<leader>b",   group = "LSP Document Symbol" },
  { "<leader>bo",  desc = "LSP Document Symbol" },

  { "<leader>c",   group = "LSP" },
  { "<leader>l",   group = "LSP Set Loc List" },
  { "<leader>ll",  desc = "LSP Set Loc List" },

  { "<leader>w",   group = "LSP Workspace" },
  { "<leader>wa",  desc = "LSP Add Workspace" },
  { "<leader>wl",  desc = "LSP List Workspace" },
  { "<leader>wr",  desc = "LSP Remove Workspace" },

  { "gd",          desc = "LSP Definition" },
  { "gD",          desc = "LSP Declaration" },
  { "gi",          desc = "LSP Implementation (works?)" },
  { "<leader>D",   desc = "LSP Type definition" },
  { "<leader>r",   group = "LSP" },
  { "<leader>e",   desc = "LSP Open Float" },
  { "<leader>z",   group = "LSP Restart" },
  { "<leader>zi",  group = "LSP Restart" },
  { "<leader>zig", "<cmd>LspRestart<CR>", desc = "LSP Restart" },

  { "[d",          desc = "LSP Previous Error" },
  { "]d",          desc = "LSP Next Error" },


})

local rounded_border_handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

require("mason-lspconfig").setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      handlers = rounded_border_handlers,
    })
  end,
  ["omnisharp"] = function()
    require("lspconfig")["omnisharp"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "dotnet", vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
      root_dir = function(fname)
        local lspconfig = require("lspconfig")
        local primary = lspconfig.util.root_pattern("*.sln")(fname)
        local fallback = lspconfig.util.root_pattern("*.csproj")(fname)
        return primary or fallback
      end,

      analyze_open_documents_only = false,
      enable_roslyn_analysers = true,
      enable_import_completion = true,
      enable_decompilation_support = true,
      enable_editorconfig_support = true,
      organize_imports_on_format = true,


      handlers = vim.tbl_extend("force", rounded_border_handlers, {
        ["textDocument/definition"] = require("omnisharp_extended").handler,
      }),
      filetypes = {
        "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets"
      },
    })
  end,
  ["lua_ls"] = function()
    local lua_runtime_path = vim.split(package.path, ";")
    table.insert(lua_runtime_path, "lua/?.lua")
    table.insert(lua_runtime_path, "lua/?/init.lua")

    require("lspconfig")["lua_ls"].setup({
      on_attach = on_attach,
      capabilities = capabilities,

      handlers = rounded_border_handlers,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = lua_runtime_path,
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              vim.api.nvim_get_runtime_file("", true),
              "${3rd}/love2d/library",
            },
            checkThirdParty = false,
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })
  end,
})
