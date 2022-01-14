local util = require('utils')
local opt = { silent = true }

util.map('n', '<C-p>', '<cmd>Telescope find_files hidden=true<CR>', opt)
-- util.map('n', '<Leader>fp', '<cmd>Telescope project<CR>', opt)
util.map('n', '<Leader>fc', '<cmd>Telescope commands<CR>', opt)
util.map('n', '<Leader>fC', ':Cheatsheet<CR>', opt)
util.map('n', '<Leader>f/', '<cmd>Telescope live_grep<CR>', opt)
util.map('n', '<Leader>fb', '<cmd>Telescope buffers<CR>', opt)
util.map('n', '<Leader>fB', '<cmd>Telescope builtin<CR>', opt)
util.map('n', '<Leader>fh', '<cmd>Telescope help_tags<CR>', opt)

require 'telescope'.load_extension('gh')
require 'telescope'.load_extension('ghq')
require 'telescope'.setup {
}

vim.cmd[[
augroup transparent-windows
  autocmd!
  autocmd FileType TelescopePrompt  set winblend=10  
  autocmd FileType TelescopeResults set winblend=10  
  autocmd User TelescopePreviewerLoaded set winblend=10
augroup END
]]
