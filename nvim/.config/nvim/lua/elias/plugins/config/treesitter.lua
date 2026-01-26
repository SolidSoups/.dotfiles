local treesitter = require("nvim-treesitter")

treesitter.setup({
  highlight = { enable = true },
  indent = { enable = true, disable = {"glsl"} },
})

treesitter.install({
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
  "json",
  "cpp",
  "c_sharp",
  "cmake",
  "css",
  "html",
  "python",
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    callback = function()
        pcall(vim.treesitter.start)
        -- Don't set indentexpr for GLSL files
        if vim.bo.filetype ~= "glsl" then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
})
