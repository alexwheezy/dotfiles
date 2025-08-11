-- Lightweight yet powerful formatter plugin for Neovim
MiniDeps.later(function()
  MiniDeps.add { source = 'stevearc/conform.nvim' }
  require('conform').setup {
    notify_on_error = true,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      rust = { 'rustfmt' },
      lua = { 'stylua' },
      zig = { 'zigfmt' },
    },
  }
end)

-- vim: ts=2 sts=2 sw=2 et
