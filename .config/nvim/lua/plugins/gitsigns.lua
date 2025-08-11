-- Adds git related signs to the gutter, as well as utilities for managing changes
MiniDeps.now(function()
  MiniDeps.add { source = 'lewis6991/gitsigns.nvim' }
  require('gitsigns').setup {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end)

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end)

      -- Actions
      -- normal mode
      map('n', '<leader>hs', gitsigns.stage_hunk)
      map('n', '<leader>hr', gitsigns.reset_hunk)
      map('n', '<leader>hS', gitsigns.stage_buffer)
      map('n', '<leader>hR', gitsigns.reset_buffer)
      map('n', '<leader>hp', gitsigns.preview_hunk)
      map('n', '<leader>hi', gitsigns.preview_hunk_inline)
      map('n', '<leader>hb', function()
        gitsigns.blame_line { full = true }
      end)
      map('n', '<leader>hd', gitsigns.diffthis)
      map('n', '<leader>hD', function()
        gitsigns.diffthis '~'
      end)
      map('n', '<leader>hQ', function()
        gitsigns.setqflist 'all'
      end)
      map('n', '<leader>hq', gitsigns.setqflist)

      -- visual mode
      map('v', '<leader>hs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end)

      map('v', '<leader>hr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end)

      -- Toggles
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
      map('n', '<leader>tw', gitsigns.toggle_word_diff)

      -- Text object
      map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
    end,
  }
end)

-- vim: ts=2 sts=2 sw=2 et
