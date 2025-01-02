return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",

    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("neogit").setup({})
    vim.keymap.set("n", "<leader>gg", "<CMD>Neogit<CR>", { desc = "Neogit" })
    require("which-key").add({
      { "<leader>g", group = "Neogit" }
    })
  end,
}
