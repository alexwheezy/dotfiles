return {
  -- A neovim plugin helping you establish good command workflow and habit
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  opts = {
    disable_mouse = false,
    resetting_keys = {
      ["-"] = { "n" },
      ["+"] = { "n" },
    },
  },
}
