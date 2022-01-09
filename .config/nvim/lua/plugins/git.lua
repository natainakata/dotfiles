local util = require('utils')
local opt = { silent = true }

util.map('n', '[git]', '<Nop>')
util.map('n', '<Leader>g', '[git]')
util.map('n', '[git]f', '<cmd>Telescope git_files hidden = true<CR>', opt)
util.map('n', '[git]s', '<cmd>Telescope git_status<CR>', opt)
util.map('n', '[git]b', '<cmd>Telescope git_branches<CR>', opt)
util.map('n', '[git]c', '<cmd>Telescope git_commit<CR>', opt)
util.map('n', '[git]is', ':Gina status<CR>', opt)
util.map('n', '[git]ic', ':Gina commit<CR>', opt)
util.map('n', '[git]ip', ':Gina push<CR>', opt)

