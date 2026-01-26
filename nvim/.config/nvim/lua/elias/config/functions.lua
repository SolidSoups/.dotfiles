
-- Filter quick fix list for only unique files
vim.api.nvim_create_user_command("DedupeQF", function()
  local qf = vim.fn.getqflist();
  local seen = {}
  local unique = {}
  for _, item in pairs(qf) do
    local fname = vim.fn.bufname(item.bufnr);
    if not seen[fname] then
      seen[fname] = true
      item.lnum = 1;
      item.col = 1;
      table.insert(unique, item)
    end
  end
  vim.fn.setqflist(unique);
end, {})

-- Add item to quick fix list
vim.api.nvim_create_user_command("QFAdd", function()
vim.fin.setqflist({{
    filename = vim.fn.expand('%:p'),
    lnum = 1,
    col = 1,
    text = ''
  }}, 'a')
end, {})

-- clear the quick fix list
vim.api.nvim_create_user_command("QFClear", function()
  vim.fn.setqflist({})
end,  {})
