-- Python-specific settings (PEP 8 compliant)
return {
  options = {
    -- PEP 8: Use 4 spaces for indentation
    shiftwidth = 4,
    tabstop = 4,
    softtabstop = 4,
    expandtab = true,

    -- Line length (88 chars is Black's default, PEP 8 recommends 79)
    textwidth = 0,        -- Disable auto-wrap (use formatter instead)
    colorcolumn = "88",   -- Visual guide only

    -- Better Python indentation
    autoindent = true,
    smartindent = true,
  },
  keymaps = {
    { "n", "<leader>rr", "<cmd>!python %<cr>", { desc = "Run Python script" } },
    { "n", "<leader>rt", "<cmd>!python -m pytest %<cr>", { desc = "Run pytest on current file" } },
    { "n", "<leader>ra", "<cmd>!python -m pytest<cr>", { desc = "Run all pytest tests" } },
  },
}
