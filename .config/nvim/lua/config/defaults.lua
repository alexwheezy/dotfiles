return {
  news = {
    -- When enabled, NEWS.md will be shown when changed.
    -- Same but for Neovim's news.txt
    neovim = true,
  }, -- icons used by other plugins
  icons = {
    misc = {
      dots = "󰇘",
    },
    dap = {
      Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
      Breakpoint = " ",
      BreakpointCondition = " ",
      BreakpointRejected = { " ", "DiagnosticError" },
      LogPoint = ".>",
    },
    diagnostics = {
      Error = " ",
      Warn = " ",
      Hint = " ",
      Info = " ",
    },
    git = {
      added = " ",
      modified = " ",
      removed = " ",
    },
    kinds = {
      Array = " ",
      Boolean = "󰨙 ",
      Class = "󰌗 ",
      Codeium = "󰘦 ",
      Color = " ",
      Control = " ",
      Collapsed = " ",
      Constant = "󰏿 ",
      Constructor = " ",
      Copilot = " ",
      Enum = "󰕘",
      EnumMember = " ",
      Event = " ",
      Field = " ",
      File = "󰈙 ",
      Folder = " ",
      Function = "󰊕 ",
      Interface = " ",
      Key = " ",
      Keyword = " ",
      Method = "󰊕 ",
      Module = " ",
      Namespace = "󰌗 ",
      Null = "󰟢 ",
      Number = "󰎠 ",
      Object = "󰅩 ",
      Operator = " ",
      Package = " ",
      Property = " ",
      Reference = " ",
      Snippet = " ",
      String = " ",
      Struct = "󰆼 ",
      TabNine = "󰏚 ",
      Text = " ",
      TypeParameter = " ",
      Unit = " ",
      Value = " ",
      Variable = "󰀫 ",
    },
  },
  ---@type table<string, string[]|boolean>?
  kind_filter = {
    default = {
      "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      "Package",
      "Property",
      "Struct",
      "Trait",
    },
    markdown = false,
    help = false,
    -- you can specify a different filter for each filetype
    lua = {
      "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      -- "Package", -- remove package since luals uses it for control flow structures
      "Property",
      "Struct",
      "Trait",
    },
  },
  -- options from nvim_open_win()| vim.diagnostic.open_float()
  -- | vim.lsp.util.open_floating_preview()| vim.diagnostic.config()
  ---@type table
  diagnostics_options = {
    virtual_text = false,
    -- virtual_text = {
    --     severity = { min = vim.diagnostic.severity.WARN, max = vim.diagnostic.severity.ERROR },
    --     source = "if_many",
    --     spacing = 0,
    --     prefix = "●",
    -- },
    float = {
      --nvim_open_win() options
      relative = "cursor",
      -- "single": A single line box.
      -- "double": A double line box.
      -- "rounded": Like "single", but with rounded corners "╭"
      -- "solid": Adds padding by a single whitespace cell.
      -- "shadow": A drop shadow effect by blending with the
      -- "none": No border (default).
      border = "rounded",
      -- vim.lsp.util.open_floating_preview()
      max_width = math.floor(vim.o.columns * 0.84),
      max_height = math.floor(vim.o.lines * 0.6),
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      focusable = false,
      zindex = 3,
      focus = false,
      -- vim.diagnostic.open_float()
      source = "if_many",
      severity_sort = true,
    },
    update_in_insert = false,
    -- This affects the order in which signs and virtual text are displayed
    severity_sort = true,
  },
}
