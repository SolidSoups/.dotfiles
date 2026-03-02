return {
	{
		"vague-theme/vague.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"sainnhe/sonokai",
		priority = 1000,
		config = function()
			vim.g.sonokair_enable_italic = true
		end,
	},
}
