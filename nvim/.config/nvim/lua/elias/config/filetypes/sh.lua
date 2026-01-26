return {
  options = {
    shiftwidth = 2,
    tabstop = 2,
    expandtab = true,
    textwidth = 80,
  },
  keymaps = {
    {"n", "<leader>x", "<cmd>!chmod +x %<cr>", { desc = "Make executable"}},
    {"n", "<leader>rr", "<cmd>!./%<cr>", { desc = "Run script"}},
    {"n", "<leader>sc", "<cmd>!shellcheck %<cr>", { desc = "Shellcheck"}},
  },
}
