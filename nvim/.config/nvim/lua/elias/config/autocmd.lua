
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Rotate LSP log if it gets too big (check on startup)
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Rotate LSP log if too large',
  once = true,
  callback = function()
    local log_file = vim.fn.stdpath('state') .. '/lsp.log'
    local max_size = 10 * 1024 * 1024 -- 10MB
    local stat = vim.loop.fs_stat(log_file)
    if stat and stat.size > max_size then
      vim.loop.fs_rename(log_file, log_file .. '.old')
      vim.fn.writefile({}, log_file)
    end
  end,
})

-- Clear old clangd index cache periodically (prevent corruption)
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Clear old clangd cache',
  once = true,
  callback = function()
    vim.defer_fn(function()
      local cache_dir = vim.fn.getcwd() .. '/.cache/clangd'
      local stat = vim.loop.fs_stat(cache_dir)
      -- Clear if cache is older than 7 days
      if stat and (os.time() - stat.mtime.sec > 7 * 24 * 60 * 60) then
        vim.fn.delete(cache_dir, 'rf')
      end
    end, 1000) -- Delay 1s to not slow down startup
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

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', 'dd', function()
    local qf = vim.fn.getqflist()
    local line = vim.fn.line('.')
    table.remove(qf, line)
    vim.fn.setqflist(qf, 'r')
    vim.cmd('cc ' .. math.min(line, #qf))
    end, { buffer = true })
  end,
})

-- Loader for all filetypes in the filetypes/ directory
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local filetype = args.match
    local ok, config = pcall(require, "elias.config.filetypes." .. filetype)

    if ok and type(config) == 'table' then
      -- Apply buffer-local options
      if config.options then
        for opt, value in pairs(config.options) do
          vim.opt_local[opt] = value;
        end
      end

      -- Set buffer-local keymaps
      if config.keymaps then
        for _, map in ipairs(config.keymaps) do
          vim.keymap.set(map[1], map[2], map[3], vim.tbl_extend("force", map[4] or {}, { buffer = args.buf }))
        end
      end

      -- call callback function if it exists
      if config.callback then
        pcall(config.callback)
      end
    end
  end,
})
