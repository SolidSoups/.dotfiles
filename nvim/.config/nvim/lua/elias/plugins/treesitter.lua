return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        {
            "nvim-telescope/telescope-ui-select.nvim",
        },
    },
    build = ":TSUpdate",
    config = function()
        require("elias.plugins.config.treesitter")
    end,
}
