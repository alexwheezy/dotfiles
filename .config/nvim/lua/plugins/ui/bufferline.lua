return {
  "akinsho/bufferline.nvim",
  enabled = true,
  -- version = "*", -- Using master while fix of `tbl_islist` is not added to release
  event = "VeryLazy",
  config = function()
    require("bufferline").setup({
      options = {
        -- stylua: ignore
        close_command = function(n) require("config.utils").bufremove(n) end,
        -- stylua: ignore
        right_mouse_command = function(n) require("config.utils").bufremove(n) end,
        always_show_bufferline = false,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = "slant",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local icons = require("config.defaults").icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {},
      },
      highlights = {
        buffer_visible = {
          fg = {
            attribute = "fg",
            highlight = "Normal",
          },
          bg = {
            attribute = "bg",
            highlight = "Normal",
          },
          italic = false,
        },
        buffer_selected = {
          fg = {
            attribute = "fg",
            highlight = "Normal",
          },
          bg = {
            attribute = "bg",
            highlight = "Normal",
          },
          italic = false,
        },
      },
    })
  end,
}
