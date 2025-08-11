-- Colorscheme
MiniDeps.now(function()
  MiniDeps.add { source = 'projekt0n/github-nvim-theme' }
  local specs = {
    github_dark_default = {
      syntax = {
        builtin0 = 'syntax.number',
        builtin1 = 'syntax.number',
        builtin2 = 'syntax.number',
      },
    },
  }
  require('github-theme').setup {
    options = {
      hide_end_of_buffer = false,
      transparent = true,
    },
    specs = specs,
  }
  vim.cmd 'colorscheme github_dark_default'
end)

-- vim: ts=2 sts=2 sw=2 et
