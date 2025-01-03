return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "Hoffs/omnisharp-extended-lsp.nvim",
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
    "saghen/blink.cmp",
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    }
  },
}
