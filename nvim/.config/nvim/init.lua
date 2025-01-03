require("elias.core")
require("elias.lazy")
require("nvim-web-devicons").setup({})
require("elias.lsp")

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme nordic]])

polish = function()
	require("notify").setup({
		background_colour = "#1a1b26",
	})
end
polish()

