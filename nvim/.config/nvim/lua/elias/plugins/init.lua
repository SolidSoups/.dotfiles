return {
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true,
    },
    {
        "justinmk/vim-sneak",
    },
    {
        "szw/vim-maximizer",
        config = function()
            vim.keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", { desc = "Toggle Maximize", silent=true})
        end,
    },
    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {},
    },
}
