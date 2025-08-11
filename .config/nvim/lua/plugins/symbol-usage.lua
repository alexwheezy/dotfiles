-- Plugin to display references, definitions, and implementations of document symbols.
MiniDeps.later(function()
  MiniDeps.add {
    source = 'Wansmer/symbol-usage.nvim',
  }
  require('symbol-usage').setup()
end)

-- vim: ts=2 sts=2 sw=2 et
