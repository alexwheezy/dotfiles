-- Mastering Fuzzy Search in Lua
MiniDeps.now(function()
  MiniDeps.add {
    source = 'ibhagwan/fzf-lua',
    depends = { 'nvim-tree/nvim-web-devicons' },
  }
  require('fzf-lua').setup {
    fzf_bin = 'sk',
  }

  local map = function(keys, func, desc, mode)
    local mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { desc = desc })
  end
  map('<leader>,', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', 'Switch Buffer')
  map('<leader>/', '<cmd>FzfLua live_grep cwd=/<cr>', 'Grep (Root Dir)')
  map('<leader>:', '<cmd>FzfLua command_history<cr>', 'Command History')
  -- find
  map('<leader>fb', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', 'Buffers')
  map('<leader>fc', '<cmd>FzfLua files cwd=$HOME/.config<cr>', 'Config File')
  map('<leader>ff', '<cmd>FzfLua files cwd=/<cr>', 'Files (Root Dir)')
  map('<leader>fF', '<cmd>FzfLua files cwd=vim.uv.cwd()<cr>', 'Files (cwd)')
  map('<leader>fg', '<cmd>FzfLua git_files<cr>', 'Git Files')
  map('<leader>fr', '<cmd>FzfLua oldfiles<cr>', 'Recent')
  map('<leader>fR', '<cmd>FzfLua oldfile cwd=vim.uv.cmd()<cr>', 'Recent (cwd)')
  -- git
  map('<leader>gbl', '<cmd>FzfLua git_blame<cr>', 'Blame')
  map('<leader>gbr', '<cmd>FzfLua git_branches<cr>', 'Branches')
  map('<leader>gc', '<cmd>FzfLua git_commits<cr>', 'Commits')
  map('<leader>gd', '<cmd>FzfLua git_diff<cr>', 'Diff')
  map('<leader>gf', '<cmd>FzfLua git_files<cr>', 'Files')
  map('<leader>gh', '<cmd>FzfLua git_hunks<cr>', 'Hunks')
  map('<leader>gs', '<cmd>FzfLua git_status<cr>', 'Status')
  map('<leader>gt', '<cmd>FzfLua git_tags<cr>', 'Tags')
  -- search
  map('<leader>s"', '<cmd>FzfLua registers<cr>', 'Registers')
  map('<leader>sa', '<cmd>FzfLua autocmds<cr>', 'Auto Commands')
  map('<leader>sb', '<cmd>FzfLua grep_curbuf<cr>', 'Buffer')
  map('<leader>sc', '<cmd>FzfLua command_history<cr>', 'Command History')
  map('<leader>sC', '<cmd>FzfLua commands<cr>', 'Commands')
  map('<leader>sd', '<cmd>FzfLua diagnostics_document<cr>', 'Document Diagnostics')
  map('<leader>sf', '<cmd>FzfLua live_grep cwd=$HOME/.config<cr>', 'Config File')
  map('<leader>sD', '<cmd>FzfLua diagnostics_workspace<cr>', 'Workspace Diagnostics')
  map('<leader>sg', '<cmd>FzfLua live_grep cwd=/<cr>', 'Grep (Root Dir)')
  map('<leader>sG', '<cmd>FzfLua live_grep<cr>', 'Grep (cwd)')
  map('<leader>sh', '<cmd>FzfLua help_tags<cr>', 'Help Pages')
  map('<leader>sH', '<cmd>FzfLua highlights<cr>', 'Highlight Groups')
  map('<leader>sj', '<cmd>FzfLua jumps<cr>', 'Jumplist')
  map('<leader>sk', '<cmd>FzfLua keymaps<cr>', 'Key Maps')
  map('<leader>sl', '<cmd>FzfLua loclist<cr>', 'Location List')
  map('<leader>sM', '<cmd>FzfLua man_pages<cr>', 'Man Pages')
  map('<leader>sm', '<cmd>FzfLua marks<cr>', 'Jump to Mark')
  map('<leader>sR', '<cmd>FzfLua resume<cr>', 'Resume')
  map('<leader>sq', '<cmd>FzfLua quickfix<cr>', 'Quickfix List')
  map('<leader>sw', '<cmd>FzfLua grep_cword cwd=/<cr>', 'Word (Root Dir)')
  map('<leader>sW', '<cmd>FzfLua grep_cword cwd<cr>', 'Word (cwd)')
  map('<leader>sw', '<cmd>FzfLua grep_visual cwd=/<cr>', 'Selection (Root Dir)', 'v')
  map('<leader>sW', '<cmd>FzfLua grep_visual<cr>', 'Selection (cwd)', 'v')
  map('<leader>uC', '<cmd>FzfLua colorschemes<cr>', 'Colorscheme')
end)

-- vim: ts=2 sts=2 sw=2 et
