local util = require('utils')

vim.g.mapleader = ' '

-- general keymap
util.map('n', 'j', 'gj')
util.map('n', 'gj', 'j')
util.map('n', 'k', 'gk')
util.map('n', 'gk', 'k')
util.map('n', 'U', '<C-r>')
util.map('n', '<Leader>w', ':w<CR>')
util.map('i', 'jj', '<Esc>', { silent = true })

-- window and buffer
util.map('n', 'gl', ':bnext<CR>')
util.map('n', 'gh', ':bprevious<CR>')
util.map('n', 'gH', ':blast<CR>')
util.map('n', 'gL', ':bfirst<CR>')

-- fold
util.map('n', 'Z', ':set foldmethod=indent<CR>')
