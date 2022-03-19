local opt = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap


require('gitsigns').setup()

keymap('n', '<Leader>gf', '<cmd>Telescope git_files hidden=true<CR>', opt)
keymap('n', '<Leader>gs', '<cmd>Telescope git_status<CR>', opt)
keymap('n', '<Leader>gb', '<cmd>Telescope git_branches<CR>', opt)
keymap('n', '<Leader>gc', '<cmd>Telescope git_commits<CR>', opt)
keymap('n', '<Leader>gis', ':Gina status<CR>', opt)
keymap('n', '<Leader>gic', ':Gina commit', opt)
keymap('n', '<Leader>gip', ':Gina push<CR>', opt)

