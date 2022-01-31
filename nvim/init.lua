local util = require('utils')

vim.cmd[[let g:python3_host_prog = system('echo -n $(which python3)')]]
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

require('plugins/packer')
require('options')
require('mappings')
require('plugins/statusline')
require('plugins/completion')
require('plugins/exploler')
require('plugins/lsp')
require('plugins/terminal')
require('plugins/treesitter')
require('plugins/fuzzyfinder')
require('plugins/git')
require('plugins/dashboard')
require('plugins/whichkey')
