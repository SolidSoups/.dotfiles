return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		local parsers = {
			"javascript",
			"typescript",
			"cpp",
			"c",
			"python",
			"lua",
			"css",
			"tsx",
			"gdscript",
			"gdshader",
		}
		require("nvim-treesitter").install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "cpp", "c", "python", "css" },
			callback = function()
				vim.treesitter.start()
				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo[0][0].foldmethod = "expr"
				-- experimental indentation
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				vim.wo.foldlevel = 99
			end,
		})
	end,
}
