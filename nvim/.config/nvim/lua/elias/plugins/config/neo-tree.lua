require("neo-tree").setup({
  source_selector = {
    statusline = true,
    -- would love to get git working here
  },
  default_component_configs = {
    git_status = {
      symbols = {
        -- Change type
        added     = "✚",
        deleted   = "✖",
        modified  = "",
        renamed   = "󰁕",
        -- Status type
        untracked = "",
        ignored   = "",
        unstaged  = "󰄱",
        staged    = "",
        conflict  = "",
      }
    }
  }
})

vim.keymap.set("n", "<leader>pv", function()
    local reveal_file = vim.fn.expand('%:p')
    if (reveal_file == '') then
      reveal_file = vim.fn.getcwd()
    else
      local f = io.open(reveal_file, "r")
      if (f) then
        f.close(f)
      else
        reveal_file = vim.fn.getcwd()
      end
    end
    require("neo-tree.command").execute({
      action = "focus",
      source = "filesystem",
      position = "right",
      reveal_file = reveal_file,
      reveal_force_cwd = true,
    })
  end,
  { silent = true, desc = "Open neo-tree" });
