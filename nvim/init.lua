vim.cmd[[let g:python3_host_prog = system('echo -n $(which python3)')]]
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

require('plugins')
require('options')
require('mappings')
require('rc/exploler')
require('rc/statusline')
require('rc/bufferline')
require('rc/ddc')
-- require('rc/ddu')
require('rc/lsp/init')
require('rc/fuzzyfinder')
require('rc/git')
require('rc/lexima')
--vim.cmd([[
--runtime! plugins/ddu.vim
--]])
