local util = require('utils')
local opt = { silent = true }

util.map('n', '<Leader>gf', '<cmd>Telescope git_files hidden = true<CR>', opt)
util.map('n', '<Leader>gs', '<cmd>Telescope git_status<CR>', opt)
util.map('n', '<Leader>gb', '<cmd>Telescope git_branches<CR>', opt)
util.map('n', '<Leader>gc', '<cmd>Telescope git_commit<CR>', opt)
util.map('n', '<Leader>gis', ':Gina status<CR>', opt)
util.map('n', '<Leader>gic', ':Gina commit', opt)
util.map('n', '<Leader>gip', ':Gina push<CR>', opt)

