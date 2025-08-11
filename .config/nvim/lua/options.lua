local g = vim.g
g.have_nerd_font = false
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_python3_provider = 0

vim.g.language = {
  'c',
  'cpp',
  'rust',
  'zig',
  'lua',
  'go',
  'python',
  'proto',
  'typescript',
  'javascript',
  'tsx',
  'css',
  'scss',
  'diff',
  'dockerfile',
  'gomod',
  'gosum',
  'gowork',
  'graphql',
  'html',
  'sql',
  'markdown',
  'markdown_inline',
  'json',
  'jsonc',
  'vimdoc',
  'vim',
  'cmake',
}

local o = vim.o
o.mouse = 'a'
o.hidden = true
o.magic = true
o.virtualedit = 'block'
o.clipboard = 'unnamedplus'
o.wildignorecase = true
o.swapfile = false

o.timeout = true
o.ttimeout = true
o.timeoutlen = 500
o.ttimeoutlen = 10
o.updatetime = 2000
o.hlsearch = true
o.ignorecase = true
o.smartcase = true
o.cursorline = true

o.showmode = false
o.shortmess = 'aoOTIcF'
o.scrolloff = 2
o.sidescrolloff = 5
o.ruler = false
o.showtabline = 0

o.list = true
o.listchars = 'tab:» ,nbsp:+,trail:·,extends:→,precedes:←,'
vim.opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = '~',
}

o.iskeyword = '@,48-57,192-255,_'
o.foldtext = ''
o.foldlevelstart = 99

o.grepformat = '%f:%l:%c:%m'
o.grepprg = 'rg --vimgrep'

o.undofile = true
o.linebreak = true
o.breakindent = true
o.smoothscroll = true

o.smarttab = true
o.expandtab = true
o.autoindent = true
o.tabstop = 2
o.sw = 2

o.wrap = true
o.number = true
o.relativenumber = true
o.signcolumn = 'yes'

o.textwidth = 120
o.colorcolumn = '+0'
o.winborder = 'rounded'
o.winblend = 0

o.splitright = true
o.splitbelow = true

o.cot = 'menu,menuone,noinsert,fuzzy,popup'
o.cia = 'kind,abbr,menu'
vim.opt.guicursor:remove { 't:block-blinkon500-blinkoff500-TermCursor' }

vim.g.health = { style = 'float' }
vim.cmd [[ hi EndOfBuffer guifg=#555555 ctermfg=240 ]]

-- vim: ts=2 sts=2 sw=2 et
