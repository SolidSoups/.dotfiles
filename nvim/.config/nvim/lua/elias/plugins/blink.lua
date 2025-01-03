return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',
  opts_extend = { "sources.default" },
  config = function()
    require("elias.config.blink")
  end,
}
