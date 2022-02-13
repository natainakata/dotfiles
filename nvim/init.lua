vim.cmd[[let g:python3_host_prog = system('echo -n $(which python3)')]]
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

require('plugins/packer')
require('options')
require('mappings')
require('plugins/exploler')
require('plugins/statusline')
require('plugins/ddc')
require('plugins/lsp')
require('plugins/fuzzyfinder')
require('plugins/git')
require('plugins/lexima')
