return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      -- Web development
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },

      -- Lua
      lua = { "stylua" },

      -- C/C++
      c = { "clang_format" },
      cpp = { "clang_format" },

      -- Other languages you might use
      sh = { "shfmt" },
      bash = { "shfmt" },
    },

    -- Format on save
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = false,  -- Don't fallback to LSP to avoid conflicts
    },

    -- Prettier settings
    formatters = {
      prettier = {
        prepend_args = {
          "--single-quote",
          "--trailing-comma", "es5",
          "--use-tabs", "false",
          "--tab-width", "4",
        },
      },
    },
  },
}
