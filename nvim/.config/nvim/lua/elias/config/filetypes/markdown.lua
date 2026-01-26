return {
  options = {
    formatoptions = vim.opt.formatoptions:get() .. "t",
    conceallevel = 2,
    wrapmargin = 10,
    linebreak = true,
    wrap = true,
  },
  keymaps = {
    {"n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { desc = "Markdown Preview"}},
  },
}
