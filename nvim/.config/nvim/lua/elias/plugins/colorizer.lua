return {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {},
    config = function()
      require("elias.plugins.config.colorizer")
    end,
}
