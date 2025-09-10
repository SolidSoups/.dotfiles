return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("elias.plugins.config.treesitter")
  end,
}
