local opt = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap('n', '<Leader>e', ':<C-u>Fern . -drawer -toggle<CR>', opt)

vim.cmd('let g:fern#default_hidden=1')
vim.cmd('let g:fern#renderer="nerdfont"')

