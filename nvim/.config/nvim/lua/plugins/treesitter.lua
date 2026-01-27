return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require'nvim-treesitter'.setup{
      install_dir = vim.fn.stdpath('data') .. '/site'
    }

    local parsers = {
      'javascript',
      'cpp',
      'c',
      'python',
      'lua'
    }
    require'nvim-treesitter'.install(parsers) 

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { '<filetype>' },
      callback = function() 
        vim.treesitter.start() 
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
        -- experimental indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
