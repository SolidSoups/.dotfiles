local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettier" },
    json = { "prettier" },
    python = { "black" },
    cs = { "csharpier" },
  },
  formatters = {
    csharpier = {
      command = "dotnet-csharpier",
      args = { "--write-stdout" },
      stdin = true,
    },
  },
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 5000,
  })
end, { desc = "Conform file/selection"})
