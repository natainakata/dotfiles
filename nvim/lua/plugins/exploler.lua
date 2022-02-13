local util = require('utils')
local opt = { silent = true }

util.map('n', '<Leader>e', ':<C-u>Fern . -drawer -toggle<CR>', { silent = true})

vim.cmd('let g:fern#default_hidden=1')
vim.cmd('let g:fern#renderer="nerdfont"')

