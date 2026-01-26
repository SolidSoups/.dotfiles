return {
  'hrsh7th/nvim-cmp',
  event = "InsertEnter",
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',     -- LSP completion source
    'hrsh7th/cmp-buffer',        -- Buffer words source
    'hrsh7th/cmp-path',          -- Filesystem paths source
    'hrsh7th/cmp-cmdline',       -- Command-line completion
    'hrsh7th/cmp-nvim-lsp-signature-help', -- Signature help
    -- Removed cmp_luasnip temporarily to debug
  },
  config = function()
    require("elias.plugins.config.nvim-cmp")
  end,
}
