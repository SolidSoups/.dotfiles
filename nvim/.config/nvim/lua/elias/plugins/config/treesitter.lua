local configs = require("nvim-treesitter.configs")

configs.setup({
  ensure_installed = {
    "c",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "elixir",
    "heex",
    "javascript",
    "typescript",
    "tsx",
    "html",
    "css",
    "json",
    "cpp",
    "c_sharp",
    "cmake",
    "glsl",
  },
  sync_install = false,
  highlight = { enable = true },
  indent = {
    enable = false, -- Disable default indent
  },
  yati = {
    enable = true,
    default_lazy = true,
    default_fallback = "auto",

    -- Suppress yati for these filetypes
    disable = {},
  },
})
