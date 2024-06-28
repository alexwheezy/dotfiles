-- Enable the new |lua-loader| that byte-compiles and caches lua files.
vim.loader.enable()

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
require("config.lazy")

-- Setup editor options -> autocmds -> mappings
require("config.autocmds")
require("config.defaults")
require("config.keymaps")
require("config.options")
require("util.ui")
require("util.lualine")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
