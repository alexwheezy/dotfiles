return {
  "SmiteshP/nvim-navic",
  lazy = false,
  init = function()
    vim.g.navic_silence = true
    require("util.lsp").on_attach(function(client, buffer)
      if client.supports_method("textDocument/documentSymbol") then
        require("nvim-navic").attach(client, buffer)
      end
    end)
  end,
  opts = function()
    return {
      separator = " ",
      highlight = true,
      depth_limit = 2,
      icons = require("config.defaults").icons.kinds,
      lazy_update_context = false,
    }
  end,
}
