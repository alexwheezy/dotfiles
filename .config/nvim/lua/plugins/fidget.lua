-- Extensible UI for Neovim notifications and LSP progress messages
MiniDeps.add {
  source = 'j-hui/fidget.nvim',
}
require('fidget').setup {
  notification = {
    window = {
      winblend = vim.o.pumblend,
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
