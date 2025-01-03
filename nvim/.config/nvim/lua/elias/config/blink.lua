local border = 'solid'

require("blink.cmp").setup({
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    providers = {
      snippets = {
        min_keyword_length = 1,
        score_offset = -1,
      },
      path = {
        opts = { get_cwd = vim.uv.cwd },
      },
      buffer = {
        fallbacks = {},
        max_items = 4,
        min_keyword_length = 4,
        score_offset = -3,
      },
    },
  },
  completion = {
    menu = {
      border = border,
    },
    documentation = {
      window = {
        border = border
      }
    }
  },
  signature = {
    window = {
      border = border,
    },
    enabled = true,
  },
  appearance = {
    -- Sets the fallback highlight groups to nvim-cmp's highlight groups
    -- Useful for when your theme doesn't support blink.cmp
    -- Will be removed in a future release
    use_nvim_cmp_as_default = true,
    -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'mono'
  },
  keymap = {
    preset = 'default',
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide" },
    ["<C-y>"] = { "select_and_accept" },

    ["<C-p>"] = { "select_prev", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },

    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },

    ["<C-l>"] = { "snippet_forward", "fallback" },
    ["<C-h>"] = { "snippet_backward", "fallback" },
  },
})
