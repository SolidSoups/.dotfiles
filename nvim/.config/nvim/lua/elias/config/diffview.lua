require("diffview").setup({})
vim.keymap.set("n", "<leader>dv", "<CMD>DiffviewOpen<CR>", { desc = "Open Diffview"})
vim.keymap.set("n", "<leader>df", "<CMD>DiffviewFileHistory<CR>", { desc = "File History Diffview"})
vim.keymap.set("n", "<leader>dc", "<CMD>DiffviewFileHistory %<CR>", { desc = "File History % Diffview"})
vim.keymap.set("n", "<leader>dm", "<CMD>DiffviewOpen master<CR>", { desc = "Open Master Diffview"})
vim.keymap.set("n", "<leader>dq", "<CMD>DiffviewClose<CR>", { desc = "Close Diffview"})

require("which-key").add({
  { "<leader>d", group = "Diff View" }
})
