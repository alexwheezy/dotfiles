-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- Expand %% to current directory
vim.cmd([[ cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%']])

-- Python 3 is the default
vim.g.python3_host_prog = "/usr/bin/python3"

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`
local opt = vim.opt

-- Make line numbers default
opt.number = true
-- You can also add relative line numbers, to help with jumping.
-- Experiment for yourself to see if you like it!
opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Wrap lines when they are too long
opt.wrap = true

-- Number of visual spaces per TAB
opt.tabstop = 4

-- Number of spacesin tab when editing
opt.softtabstop = 4

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
opt.clipboard = "unnamedplus"

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Maximum width of text that is being inserted
opt.textwidth = 100

-- Height of the command bar
opt.cmdheight = 2

-- Colorcolumn is used to indicate a column after 'textwidth'
opt.colorcolumn = "100"
opt.statuscolumn = [[%!v:lua.require'util.ui'.statuscolumn()]]

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Fill characters in various places
opt.fillchars = { eob = "~" }

-- Which characters to use for auto wrapping
opt.whichwrap:append("<,>,[,],h,l")

-- Keywords that are valid identifiers
opt.iskeyword = "@,48-57,192-255,_"

-- Winbar is displayed at the top of the window
-- opt.winbar = "%=%m %f"

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 5

-- Enable 24-bit RGB color in the terminal
opt.termguicolors = true

-- When there is a previous search pattern, highlight all its matches.
opt.hlsearch = true

local function escape(str)
  -- You need to escape these characters to work correctly
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

-- Recommended to use lua template string
local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

vim.opt.langmap = vim.fn.join({
  -- | `to` should be first     | `from` should be second
  escape(ru_shift)
    .. ";"
    .. escape(en_shift),
  escape(ru) .. ";" .. escape(en),
}, ",")
