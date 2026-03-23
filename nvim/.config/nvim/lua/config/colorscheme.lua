require("vague").setup({
	transparent = true,
})

vim.g.sonokai_transparent_background = 1
vim.cmd("colorscheme sonokai")

-- Make split seperators more visible with transparency
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#89b4fa", bg = "NONE" })
-- Also highlight inactive statuslines with the same color
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#89b4fa", bg = "NONE" })
