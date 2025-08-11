-- A plugin that makes Neovim more friendly to non-English input methods
MiniDeps.now(function()
  MiniDeps.add { source = 'Wansmer/langmapper.nvim' }
  require('langmapper').setup()
  require('langmapper').automapping { global = true, buffer = true }

  local function escape(str)
    local escape_chars = [[;,."|\]]
    return vim.fn.escape(str, escape_chars)
  end

  local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
  local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
  local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
  local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

  vim.opt.langmap = vim.fn.join({
    escape(ru_shift) .. ';' .. escape(en_shift),
    escape(ru) .. ';' .. escape(en),
  }, ',')
end)

-- vim: ts=2 sts=2 sw=2 et
