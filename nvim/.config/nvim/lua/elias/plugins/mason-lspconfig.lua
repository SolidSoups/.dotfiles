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
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    priority = 98,
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        -- Formatters
        "stylua",       -- Lua
        "shfmt",        -- Shell
        "prettier",     -- JS/TS/CSS/HTML/JSON/YAML/Markdown
        "ruff",         -- Python formatter (handles formatting + imports)
      },
      auto_update = false,
      run_on_start = true,
    },
  },
}
