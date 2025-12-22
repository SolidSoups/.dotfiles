
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = "*.md",
  callback = function()
    vim.cmd([[
      setlocal wrapmargin=10
      setlocal formatoptions+=t
      setlocal linebreak
      setlocal wrap
    ]])
  end,
})


local function load_project_config()
  local config_file = vim.fn.getcwd() .. "/.nvim.lua"
  if vim.fn.filereadable(config_file) == 1 then
    dofile(config_file);
  end
end
vim.api.nvim_create_autocmd({"DirChanged", "VimEnter"}, {
  callback = load_project_config,
})

-- Better indentation for JS/TS files with template strings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.bo.cindent = true
    vim.bo.cinoptions = "L0,l1,(0,Ws,J1"
    vim.bo.indentkeys = "0{,0},0),0],!^F,o,O,e,*<Return>"

    -- Use custom indent expression for better template string handling
    vim.bo.indentexpr = "v:lua.require('elias.utils.indent').get_indent()"
  end,
})

-- Disable heavy features for temporary files (like Claude Code prompt editing)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "/tmp/*", "/private/tmp/*", "/var/folders/*" },
  callback = function(args)
    -- Disable LSP
    vim.defer_fn(function()
      vim.lsp.stop_client(vim.lsp.get_clients({ bufnr = args.buf }))
    end, 100)

    -- Disable render-markdown
    local ok, render_markdown = pcall(require, 'render-markdown')
    if ok then
      render_markdown.disable()
    end

    -- Disable treesitter features that might be slow
    vim.bo[args.buf].syntax = 'on'  -- Use basic syntax instead
  end,
})
