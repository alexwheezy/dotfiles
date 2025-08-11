local map = vim.keymap.set

-- clear highlights on search when pressing <Esc> in normal mode
map('n', '<Esc>', '<cmd>nohlsearch<cr>')
map({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>write<cr><esc>', { desc = 'Save File' })
map({ 'i', 'x', 'n', 's' }, '<leader>rs', '<cmd>source %<cr><esc>', { desc = 'Reload File' })

-- keybinds to make split navigation easier.
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- buffers
map('n', '<S-Tab>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
map('n', '<Tab>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })

-- windows
map('n', '<leader>w-', '<C-w>s', { desc = 'Split Window Below', remap = true })
map('n', '<leader>w|', '<C-w>v', { desc = 'Split Window Right', remap = true })
map('n', '<leader>wd', '<C-w>c', { desc = 'Delete Window', remap = true })

-- better up/down lines
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- increment/decrement numbers
map('n', '+', '<C-a>', { desc = 'Increment' })
map('n', '-', '<C-x>', { desc = 'Decrement' })

-- repeat macro
map('n', 'Q', '@@')

-- vim: ts=2 sts=2 sw=2 et
