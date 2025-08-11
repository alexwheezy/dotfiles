return {
  cmd = { 'zls' },
  filetypes = { 'zig', 'zir' },
  root_markers = { 'zls.json', 'build.zig', '.git' },
  workspace_required = false,
  on_attach = function(_, bufnr)
    -- Initial inlay hint display.
    -- Idk why but without the delay inlay hints aren't displayed at the very start.
    vim.defer_fn(function()
      local mode = vim.api.nvim_get_mode().mode
      vim.lsp.inlay_hint.enable(mode == 'n' or mode == 'v', { bufnr = bufnr })
    end, 500)
  end,
}
