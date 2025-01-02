local opts = { noremap = true, silent = true }

local actions = require("telescope.actions")
local telescope = require("telescope")
telescope.setup({
  defaults = {
    layout_config = {
      horizontal = {
        preview_cutoff = 0,
      },
    },
    layout_strategy = "vertical",
    path_display = { "truncate" },
    mappings = {
      i = {
        ["<C-q>"] = actions.send_selected_to_qflist,
        ["<C-w>"] = actions.send_to_qflist,
        ["<C-d>"] = actions.delete_buffer,
      },
      n = {
        ["<C-q>"] = actions.send_selected_to_qflist,
        ["<C-w>"] = actions.send_to_qflist,
        ["<C-d>"] = actions.delete_buffer,
      },
    },
  },
})
telescope.load_extension("zf-native")
telescope.load_extension("ui-select")

local function search_vimrc()
  require("telescope.builtin").find_files({
    prompt_title = "< NVIM Config >",
    cwd = "~/.config/nvim/",
  })
end

local function search_dotfiles()
  require("telescope.builtin").find_files({
    prompt_title = "< .dotfiles >",
    cwd = vim.fn.expand("~/.dotfiles"),
    hidden = true,
    file_ignore_patterns = { "%.git/", "%.stow%-local%-ignore", ".gitignore" },
  })
end

local function extend_opts(desc)
  return vim.tbl_extend("force", opts, { desc = desc })
end

vim.keymap.set("n", "<leader>vrc", search_vimrc, extend_opts("Search NVIM config files"))
vim.keymap.set("n", "<leader>vrd", search_dotfiles, extend_opts("Search .dotfiles"))

vim.keymap.set("n", "<C-f>", require("telescope.builtin").find_files, extend_opts("Find files"))
vim.keymap.set("n", "<C-p>", require("telescope.builtin").git_files, extend_opts("Find Git files"))
vim.keymap.set("n", "<C-b>", require("telescope.builtin").buffers, extend_opts("List open buffers"))
vim.keymap.set("n", "<C-g>", require("telescope.builtin").live_grep, extend_opts("Live grep search"))

vim.keymap.set("n", "<leader>hh", require("telescope.builtin").quickfixhistory, extend_opts("Show quickfix history"))
vim.keymap.set("n", "<leader>ht", require("telescope.builtin").help_tags, extend_opts("Search help tags"))

require("which-key").add({
  { "<leader>v", group = "Search files"},
  { "<leader>vr", group = "Search files"},

  { "<leader>h", group = "Help"}
})
