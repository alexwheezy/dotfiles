MiniDeps.add {
  source = 'saghen/blink.cmp',
}

require('blink.cmp').setup {
  keymap = {
    preset = 'super-tab',
  },

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono',
  },

  completion = {
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },

    menu = {
      auto_show = true,
      winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
      winblend = vim.o.pumblend,
      draw = {
        treesitter = { 'lsp' },
      },
    },

    documentation = { auto_show = true, auto_show_delay_ms = 200 },

    trigger = {
      prefetch_on_insert = true,
      show_on_keyword = true,
      show_on_trigger_character = true,
      show_on_insert_on_trigger_character = true,
      show_on_accept_on_trigger_character = true,
    },
  },

  sources = {
    default = { 'lsp', 'path', 'buffer' },
  },

  fuzzy = { implementation = 'lua' },
  signature = { enabled = true },
}

-- vim: ts=2 sts=2 sw=2 et
