return {
  "nvim-telescope/telescope.nvim",
  version = "0.1.5",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope-ui-select.nvim",
    "natecraddock/telescope-zf-native.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("elias.config.telescope")
  end,
}
