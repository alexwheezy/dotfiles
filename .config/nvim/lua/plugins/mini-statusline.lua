-- Minimal and fast statusline module with opinionated default look
MiniDeps.add { source = 'echasnovski/mini.statusline' }
require('mini.statusline').setup {
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
      local git = MiniStatusline.section_git { trunc_width = 40 }
      local diff = MiniStatusline.section_diff { trunc_width = 75 }
      local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
      local lsp = MiniStatusline.section_lsp { trunc_width = 75 }
      local filename = MiniStatusline.section_filename { trunc_width = 140 }
      local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
      local location = function()
        local cur = vim.fn.line '.'
        local total = vim.fn.line '$'
        if cur == 1 then
          return '[top]'
        elseif cur == total then
          return '[bot]'
        else
          return string.format('[%02d%%%%]', math.floor(cur / total * 100))
        end
      end
      local search = function(trunc_width)
        local default = trunc_width or 75
        if MiniStatusline.is_truncated(default) then
          return '%1l'
        end
        return '%1l:%01v'
      end
      return MiniStatusline.combine_groups {
        { hl = mode_hl, strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- End left alignment
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl, strings = { search(), location() } },
      }
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
