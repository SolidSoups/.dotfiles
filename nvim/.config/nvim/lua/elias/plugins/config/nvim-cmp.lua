local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    -- Tab accepts/confirms completion only if explicitly selected
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = false })
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- Shift+Tab jumps backwards in snippets
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- Alt+j to navigate down the completion menu
    ['<M-j>'] = cmp.mapping.select_next_item(),

    -- Alt+k to navigate up the completion menu
    ['<M-k>'] = cmp.mapping.select_prev_item(),

    -- Enter always goes to next line (never accepts completion)
    ['<CR>'] = cmp.mapping(function(fallback)
      fallback()
    end, { 'i' }),

    -- Ctrl+Space to manually trigger completion
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Ctrl+S to trigger snippet completion
    ['<C-s>'] = cmp.mapping.complete({
      config = {
        sources = {
          { name = 'luasnip' }
        }
      }
    }),

    -- Ctrl+e to close completion menu
    ['<C-e>'] = cmp.mapping.abort(),

    -- Ctrl+d/u to scroll docs
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
  }),

  sources = cmp.config.sources({
    {
      name = 'nvim_lsp',
      priority = 1000,
      entry_filter = function(entry, ctx)
        -- Filter out snippet completions from LSP
        return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Snippet'
      end
    },
    { name = 'nvim_lsp_signature_help', priority = 900 },  -- Signature help
    { name = 'buffer', priority = 500 },     -- Buffer word completions
    { name = 'path', priority = 250 },       -- Path completions
    -- Snippets removed from default sources, use Ctrl+S to trigger
  }),

  completion = {
    completeopt = 'menu,menuone,noinsert',
  },

  experimental = {
    ghost_text = false,  -- Disabled to prevent view shifting on long completions
  },
})

-- Command-line completion for '/'
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Command-line completion for ':'
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
