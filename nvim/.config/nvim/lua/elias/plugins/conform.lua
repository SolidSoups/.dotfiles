return {
  'stevearc/conform.nvim',
  lazy = false, -- Load immediately so it's available
  priority = 100,
  opts = {
    formatters_by_ft = {
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      lua = { 'stylua' },
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescriptreact = { 'prettier' },
      css = { 'prettier' },
      html = { 'prettier' },
      json = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      python = { 'ruff_format' },
    },
    -- Format options
    format_on_save = false, -- Disable auto-format on save (use <leader>lf instead)
    formatters = {
      shfmt = {
        prepend_args = { '-i', '2' },
      },
    },
  },
}
