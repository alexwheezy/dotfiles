return {
  "Wansmer/symbol-usage.nvim",
  event = "BufReadPre",
  config = function(_, opts)
    require("symbol-usage").setup(opts)
  end,
}
