-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"





-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    {import = "elias.plugins"},
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
  rocks = { enabled = false },
})


-- web devicons setup
require("nvim-web-devicons").setup({})


-- Setup mason.nvim
require("mason").setup({
  ensure_installed = { "csharpier", "netcoredbg" },
})
---@diagnostic disable-next-line: missing-fields
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
	vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.keymap.set("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	vim.keymap.set("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	vim.keymap.set("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	vim.keymap.set("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	vim.keymap.set("n", "<leader>dl", "<cmd>lua vim.lsp.diagnostic.setloclist()<CR>", opts)
end

local rounded_border_handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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
			root_dir = function(fname)
				local lspconfig = require("lspconfig")
				local primary = lspconfig.util.root_pattern("*.sln")(fname)
				local fallback = lspconfig.util.root_pattern("*.csproj")(fname)
				return primary or fallback
			end,
			analyze_open_documents_only = true,
			organize_imports_on_format = true,
			handlers = vim.tbl_extend("force", rounded_border_handlers, {
				["textDocument/definition"] = require("omnisharp_extended").handler,
			}),
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
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
})


-- highlight text yank
local augroup = vim.api.nvim_create_augroup
local yank_group = augroup('HighlightedYank', {})
local autocmd = vim.api.nvim_create_autocmd
autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 80,
    })
  end,
})
