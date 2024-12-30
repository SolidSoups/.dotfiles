return {
  "nvim-telescope/telescope.nvim",
  version = "0.1.5",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope-ui-select.nvim",
		"natecraddock/telescope-zf-native.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local opts = { noremap = true, silent = true }

    local actions = require("telescope.actions")
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        layout_config = {
          horizontal = {
            preview_cutoff = 0,
          },
        },
        layout_strategy = "vertical",
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-q>"] = actions.send_selected_to_qflist,
            ["<C-w>"] = actions.send_to_qflist,
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["<C-q>"] = actions.send_selected_to_qflist,
            ["<C-w>"] = actions.send_to_qflist,
            ["<C-d>"] = actions.delete_buffer,
          },
        },
      },
    })
    telescope.load_extension("zf-native")
    telescope.load_extension("ui-select")

    local function search_vimrc()
      require("telescope.builtin").find_files({
        prompt_title = "< NVIM Config >",
        cwd = "~/.config/nvim/",
      })
    end

    vim.keymap.set("n", "<leader>vrc", search_vimrc, vim.tbl_extend("force", opts, { desc = "Search NVIM config files" }))
    vim.keymap.set("n", "<C-f>", require("telescope.builtin").find_files, vim.tbl_extend("force", opts, { desc = "Find files" }))
    vim.keymap.set("n", "<C-p>", require("telescope.builtin").git_files, vim.tbl_extend("force", opts, { desc = "Find Git files" }))
    vim.keymap.set("n", "<C-b>", require("telescope.builtin").buffers, vim.tbl_extend("force", opts, { desc = "List open buffers" }))
    vim.keymap.set("n", "<C-g>", require("telescope.builtin").live_grep, vim.tbl_extend("force", opts, { desc = "Live grep search" }))
    vim.keymap.set("n", "<leader>hh", require("telescope.builtin").quickfixhistory, vim.tbl_extend("force", opts, { desc = "Show quickfix history" }))
    vim.keymap.set("n", "<leader>ht", require("telescope.builtin").help_tags, vim.tbl_extend("force", opts, { desc = "Search help tags" }))
  end,
}
