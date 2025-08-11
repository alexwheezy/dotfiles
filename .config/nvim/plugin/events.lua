local api = vim.api
local au = api.nvim_create_autocmd
local group = api.nvim_create_augroup('AutocmdGroup', {})

au('TextYankPost', {
  group = group,
  callback = function()
    vim.hl.on_yank()
  end,
  desc = 'Highlight when yanking (copying) text',
})

au('BufWritePre', {
  group = group,
  pattern = '*',
  command = [[%s/\s\+$//e]],
  desc = 'Remove trailing whitespaces in all files',
})

au('InsertLeave', {
  group = group,
  pattern = '*',
  command = 'set nopaste',
  desc = 'Turn off paste mode when leaving insert mode',
})

au('FileType', {
  group = group,
  pattern = {
    'PlenaryTestPopup',
    'checkhealth',
    'dbout',
    'gitsigns-blame',
    'grug-far',
    'help',
    'lspinfo',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'minideps-confirm',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
  desc = 'Close some filetype with <q>',
})

vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = { 'man' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
  desc = 'Make it easier to close man-files when opened inline',
})

au('FileType', {
  group = group,
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  desc = 'Wrap and check for spell in text filetypes',
})

au('FileType', {
  group = group,
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
  desc = 'Fix conceallevel for json files',
})

au('BufWritePre', {
  group = group,
  callback = function(event)
    if event.match:match '^%w%w+:[\\/][\\/]' then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
  desc = 'Auto create dir when saving a file, in case some intermediate directory does not exist',
})

au('LspAttach', {
  group = group,
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('<leader>rn', vim.lsp.buf.rename, 'Rename')
    map('<leader>ra', vim.lsp.buf.code_action, 'Goto Code Action', { 'n', 'x' })
    map('<leader>gd', '<cmd>FzfLua lsp_definitions jump1=true ignore_current_line=true<cr>', 'Goto Definition')
    map('<leader>gr', '<cmd>FzfLua lsp_references jump1=true ignore_current_line=true<cr>', 'Goto References')
    map('<leader>gI', '<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>', 'Goto Implementation')
    map('<leader>gy', '<cmd>FzfLua lsp_typedefs jump1=true ignore_current_line=true<cr>', 'Goto Type Definition')
    map('<leader>ss', function()
      require('fzf-lua').lsp_document_symbols {
        regex_filter = symbols_filter,
      }
    end, 'Goto Symbol')
    map('<leader>sS', function()
      require('fzf-lua').lsp_live_workspace_symbols {
        regex_filter = symbols_filter,
      }
    end, 'Goto Symbol (Workspace)')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if
      client
      and client.supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
    then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = group,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = group,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = group,
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = group, buffer = event2.buf }
        end,
      })
    end

    if client and client.supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, 'Toggle Inlay Hints')
    end
  end,
})

au('UIEnter', {
  group = group,
  once = true,
  callback = function()
    vim.schedule(function()
      require('dashboard').show()

      vim.lsp.enable {
        'lua_ls',
        'rust_analyzer',
        'zls',
      }

      vim.diagnostic.config {
        severity_sort = true,
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font or {},
        virtual_text = false,
        -- virtual_text = {
        --   source = 'if_many',
        --   spacing = 2,
        --   format = function(diagnostic)
        --     local diagnostic_message = {
        --       [vim.diagnostic.severity.ERROR] = diagnostic.message,
        --       [vim.diagnostic.severity.WARN] = diagnostic.message,
        --       [vim.diagnostic.severity.INFO] = diagnostic.message,
        --       [vim.diagnostic.severity.HINT] = diagnostic.message,
        --     }
        --     return diagnostic_message[diagnostic.severity]
        --   end,
        -- },
        virtual_lines = {
          current_line = true,
        },
      }

      vim.lsp.log.set_level(vim.log.levels.OFF)

      api.nvim_create_user_command('LspLog', function()
        vim.cmd(string.format('tabnew %s', vim.lsp.get_log_path()))
      end, {
        desc = 'Opens the Nvim LSP client log.',
      })

      api.nvim_create_user_command('LspDebug', function()
        vim.lsp.log.set_level(vim.log.levels.WARN)
      end, { desc = 'enable lsp log' })
      vim.cmd.packadd 'nohlsearch'
    end)
  end,
  desc = 'Initializer',
})

-- au('FileType', {
--   pattern = vim.g.language,
--   callback = function()
--     vim.treesitter.start()
--     vim.wo.foldmethod = 'expr'
--     vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
--     vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
--   end,
-- })

-- vim: ts=2 sts=2 sw=2 et
