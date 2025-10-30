return {
  'hrsh7th/nvim-cmp',
  event = "InsertEnter",
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',     -- LSP completion source
    'hrsh7th/cmp-buffer',        -- Buffer words source
    'hrsh7th/cmp-path',          -- Filesystem paths source
    'hrsh7th/cmp-cmdline',       -- Command-line completion
    'L3MON4D3/LuaSnip',          -- Snippet engine (required)
    'saadparwaiz1/cmp_luasnip',  -- Snippet source
  },
  config = function()
    require("elias.plugins.config.nvim-cmp")
  end,
}
