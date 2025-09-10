return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
  },
  requires = 'kevinhwang91/promise-async',
  config = function()
    vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set('n', 'zf', "<cmd>foldopen<CR>", { silent = true, desc = "Open fold" });
    vim.keymap.set('n', 'zc', "<cmd>foldclose<CR>", { silent = true, desc = "Close fold" });
    vim.keymap.set('n', 'zF', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zC', require('ufo').closeAllFolds)

    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
      end
    })
  end,
}
