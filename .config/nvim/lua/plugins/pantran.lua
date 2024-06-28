return {
  "potamides/pantran.nvim",
  lazy = false,
  config = function()
    require("pantran").setup({
      -- Default engine to use for translation. To list valid engine names run
      -- `:lua =vim.tbl_keys(require("pantran.engines"))`.
      default_engine = "yandex",
      -- Configuration for individual engines goes here.
      engines = {
        yandex = {
          -- Default languages can be defined on a per engine basis. In this case
          -- `:lua require("pantran.async").run(function()
          -- vim.pretty_print(require("pantran.engines").yandex:languages()) end)`
          -- can be used to list available language identifiers.
          default_source = "en",
          default_target = "ru",
          fallback = {
            default_source = "en",
            default_target = "ru",
          },
        },
      },
      ui = {
        width_percentage = 0.9,
        height_percentage = 0.9,
      },
      windows = {
        options = {
          {
            number = true,
            relativenumber = true,
            cursorline = true,
            cursorcolumn = true,
          },
        },
      },
    })
  end,
}
