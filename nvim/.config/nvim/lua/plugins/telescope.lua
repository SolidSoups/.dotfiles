return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-ui-select.nvim",
	},
	opts = function(_, opts)
		-- set default picker theme to ivy for all pickers
		local actions = require("telescope.actions")
		opts.defaults = require("telescope.themes").get_ivy({
			layout_config = { height = 0.30 },
			mappings = {
				i = {
					["<M-j>"] = actions.move_selection_next,
					["<M-k>"] = actions.move_selection_previous,
				},
				n = {
					["<M-j>"] = actions.move_selection_next,
					["<M-k>"] = actions.move_selection_previous,
				},
			},
		})
	end,
	config = function(_, opts)
		require("telescope").setup(opts)

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
	end,
}
