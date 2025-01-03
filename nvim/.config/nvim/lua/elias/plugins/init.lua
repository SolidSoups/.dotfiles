return {
  "godlygeek/tabular",
  "tpope/vim-eunuch",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  "numToStr/Comment.nvim",
  "tpope/vim-unimpaired",
  { "aymericbeaumet/vim-symlink",   dependencies = { "moll/vim-bbye" } },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
      require("marks").setup{
        default_mappings = true,
        signs = true,
        mappings = {},
      }
    end,
  }
}
