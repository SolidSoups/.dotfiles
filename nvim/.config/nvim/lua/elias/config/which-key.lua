require("which-key").setup({
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = true,
      motions = true,
      text_objects = true,

      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  icons = {
    breadcrup = "»",
    seperator = "→",
    group = "+",
  },
  keys = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
  },
  win = {
    border = "none",
    padding = { 1, 2, 1, 2 },
    wo = {
      winblend = 0,
    },
    title = true,
    title_pos = "center",
    zindex = 1000,
  },
  notify = true,
})

-- keymaps
require("which-key").add(
  {
    mode = { "n" },

    -- Neotree
    { "<leader>p",         group = "Toggle Neotree" },
    { "<leader>pv",        desc = "Toggle Neotree" },

    -- config editing
    { "<leader>x",         ":.lua<CR>",             desc = "Source current line" },
    { "<leader><leader>",  group = "Source file" },
    { "<leader><leader>x", "<cmd>source %<CR>",     desc = "Source file" },

    { "<leader>s",         group = "Split" }
  },
  {
    mode = { "v" },
    { "<leader>x",         ":lua<CR>",              desc = "Source selected lines" },
  })
