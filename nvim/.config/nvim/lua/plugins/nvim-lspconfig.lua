return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.lsp.enable({
			"clangd",
			"lua_ls",
			"tailwindcss",
			"gdscript",
		})

		-- GDScript config
		vim.lsp.config("gdscript", {
			cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
			filetypes = { "gd", "gdscript", "gdscript3" },
			root_markers = { "project.godot", ".git" },
		})

		-- Lua LS config
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostic = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							["/usr/share/nvim/runtime"] = true,
						},
					},
				},
			},
		})

		-- Clangd config
		-- vim.lsp.config("clangd", {
		-- 	on_attach = function(client, buffer)
		-- 		if client.supports_method("textDocument/inlayHints") then
		-- 			vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
		-- 		end
		-- 	end,
		-- })
	end,
}
