return {
	"echasnovski/mini.completion",
	version = false,
	event = "InsertEnter",
	config = function()
		-- Setup basic shit
		require("mini.completion").setup({
			delay = { completion = 200, info = 400, signature = 100 },
			lsp_completion = {
				source_func = "omnifunc",
				auto_setup = true,
			},
			window = {
				info = { border = "single" },
				signature = { border = "single" },
			},
		})

		-- DO NOT TRIGGER IN TELESCOPE BUFFER
		vim.api.nvim_create_autocmd("BufEnter", {
			callback = function()
				if vim.bo.buftype == "prompt" then
					vim.b.minicompletion_disable = true
				end
			end,
		})
	end,
}
