return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  --@module "ible"
  --@type ibl.config
  opts = {},
  config = function()
    require("ibl").setup()
  end,
}
