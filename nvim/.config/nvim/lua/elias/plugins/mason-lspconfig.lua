return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    priority = 100,
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    priority = 99,
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      require("elias.plugins.config.mason-lspconfig")
    end,
  },
}
