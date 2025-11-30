return {
	'stevearc/oil.nvim',
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	lazy = false,
	config = function()
		require("elias.plugins.config.oil")
	end
}
