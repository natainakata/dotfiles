local util = require('utils')

util.map('n', 'j', 'gj')
util.map('n', 'k', 'gk')
util.g.mapleader = ' '
util.map('n', '<Leader>w', ':w<CR>')
util.map('i', 'jj', '<Esc>', { silent = true })

util.map('n', '<Leader>T', ':TransparentToggle<CR>')
