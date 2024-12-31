CustomOilBar = function()
  local path = vim.fn.expand "%"
  path = path:gsub("oil://", "")

  return "  " .. vim.fn.fnamemodify(path, ":.")
end

require("oil").setup {
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  columns = { "icon" },
  view_options = {
    show_hidden = true,
    natural_order = true,
    is_always_hidden = function(name, _)
      local folder_skip = { "dev-tools.locks", "dune.lock", "_build", "lazy-lock.json" }
      return vim.tbl_contains(folder_skip, name) or name == '..' or name == '.git'
    end,
  },
  --keymaps = {
  --  ["<C-h>"] = false,
  --  ["<C-l>"] = false,
  --  ["<C-k>"] = false,
  --  ["<C-j>"] = false,
  --  ["<M-h>"] = "actions.select_split",
  --},
  win_options = {
    wrap = true,
    winbar = "%{v:lua.CustomOilBar()}",
  },
}

-- Open parent directory in current window
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
--vim.keymap.set("n", "<leader>pv", function()
--  vim.cmd("vsplit | wincmd l | vertical resize -20")
--  require("oil").open()
--end)

-- Open parent directory in floating window
vim.keymap.set("n", "<space>-", require("oil").toggle_float)
