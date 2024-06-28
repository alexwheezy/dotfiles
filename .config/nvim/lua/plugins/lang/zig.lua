return {
  "neovim/nvim-lspconfig",
  opts = {
    require("lspconfig").zls.setup({}),
  },
}
