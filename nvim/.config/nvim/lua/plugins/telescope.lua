return {
  'nvim-telescope/telescope.nvim', 
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    local builtin = require'telescope.builtin'
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope find files"})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Telescope live grep"})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope buffers"})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Telescope help tags"})

    local telescope = require'telescope'
    local actions = require'telescope.actions'
    telescope.setup({
      defaults = {
        preview = { treesitter = false },
        color_devicons = true,
        sorting_strategy = "ascending",
        borderchars = {
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
        },
        path_display = { "smart" },
        layout_config = {
          height = 400,
          width = 200,
          prompt_position = "top",
          preview_cutoff = 40,
        },
        mappings = {
          i = {
            ["<M-j>"] = actions.move_selection_next,
            ["<M-k>"] = actions.move_selection_previous,
          },
          n = {
            ["<M-j>"] = actions.move_selection_next,
            ["<M-k>"] = actions.move_selection_previous,
          }
        }
      }
    })
    telescope.load_extension("ui-select")
  end,
}
