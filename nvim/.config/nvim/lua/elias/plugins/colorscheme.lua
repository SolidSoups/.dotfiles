return {
  { 
    "EdenEast/nightfox.nvim",
    priority = 1000,
    lazy = false,
  }, -- lazy
  {
    "catppuccin/nvim",
    name = "catpuccin",
    priority = 1000
  },
    {
        "vague-theme/vague.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other plugins
    },
}
