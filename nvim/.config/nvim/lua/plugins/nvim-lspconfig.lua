return {
	"neovim/nvim-lspconfig",
	config = function()
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
		vim.lsp.enable("clangd")
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("tailwindcss")

		vim.lsp.config("gdscript", {
			cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
			filetypes = { "gd", "gdscript", "gdscript3" },
			root_markers = { "project.godot", ".git" },
		})
		vim.lsp.enable("gdscript")
	end,
}
