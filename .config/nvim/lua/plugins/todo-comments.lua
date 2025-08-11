-- Highlight and search for todo comments like TODO, HACK, BUG in your code base.
MiniDeps.later(function()
  MiniDeps.add {
    source = 'folke/todo-comments.nvim',
    depends = { 'nvim-lua/plenary.nvim' },
  }
  require('todo-comments').setup()

  -- Keymaps
  vim.keymap.set('n', ']t', function()
    require('todo-comments').jump_next()
  end, { desc = 'Next todo comment' })

  vim.keymap.set('n', '[t', function()
    require('todo-comments').jump_prev()
  end, { desc = 'Previous todo comment' })

  vim.keymap.set('n', '<leader>st', '<cmd>TodoFzfLua<cr>', { desc = 'Todo Search' })
end)

-- vim: ts=2 sts=2 sw=2 et
