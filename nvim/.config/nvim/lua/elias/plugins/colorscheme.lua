return {
	{
		"ellisonleao/gruvbox.nvim", 
		priority = 1000,
		config = true,
		opts = ...
	},
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nordic").load()
    end
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function ()
      require("everforest").setup({})
    end
  }
}
