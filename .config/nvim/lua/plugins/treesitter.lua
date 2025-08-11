-- Highlight, edit, and navigate code
MiniDeps.later(function()
  MiniDeps.add {
    source = 'nvim-treesitter/nvim-treesitter',
    -- Use 'master' while monitoring updates in 'main'
    checkout = 'master',
    monitor = 'main',
    -- Perform action after every checkout
    hooks = {
      post_checkout = function()
        vim.cmd 'TSUpdate'
      end,
    },
  }
  -- Possible to immediately execute code which depends on the added plugin
  require('nvim-treesitter.configs').setup {
    -- Autoinstall languages that are not installed
    auto_install = true,
    ignore_install = { 'c', 'lua', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
    incremental_selection = {
      enable = true,
    },
  }

  -- A plugin that shows the context of the currently visible buffer contents.
  MiniDeps.add {
    source = 'nvim-treesitter/nvim-treesitter-context',
    depends = { 'nvim-treesitter/nvim-treesitter' },
  }
  require('treesitter-context').setup()
end)

-- vim: ts=2 sts=2 sw=2 et
