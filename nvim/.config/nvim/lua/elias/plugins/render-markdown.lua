return {
  "MeanderingProgrammer/render-markdown.nvim",
  after = { 'nvim-treesitter' },
  requires = { 'echasnovski/mini.icons', opt = true },
  config = function() 
    require("elias.plugins.config.markdown")
  end,
}
