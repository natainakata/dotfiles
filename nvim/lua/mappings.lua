local util = require('utils')

vim.g.mapleader = ' '

-- general keymap
util.map('n', 'j', 'gj')
util.map('n', 'gj', 'j')
util.map('n', 'k', 'gk')
util.map('n', 'gk', 'k')
util.map('n', 'U', '<C-r>')
util.map('n', '<Leader>w', ':w<CR>')
util.map('i', 'jj', '<Esc>', { silent = true })
util.map('n', '<Esc><Esc>', ':nohlsearch<CR>', { silent = true })

-- window and buffer
util.map('n', 'gl', ':bnext<CR>')
util.map('n', 'gh', ':bprevious<CR>')
util.map('n', 'gH', ':blast<CR>')
util.map('n', 'gL', ':bfirst<CR>')

-- fold
util.map('n', 'Z', ':set foldmethod=indent<CR>')

-- session
util.map('n', '<Leader>ss', ':<C-u>SessionSave<CR>', { silent = true })
util.map('n', '<Leader>sl', ':<C-u>SessionLoad<CR>', { silent = true })

vim.cmd[[
nmap  <C-a>  <Plug>(dps-dial-increment)
nmap  <C-x>  <Plug>(dps-dial-decrement)
xmap  <C-a>  <Plug>(dps-dial-increment)
xmap  <C-x>  <Plug>(dps-dial-decrement)
xmap g<C-a> g<Plug>(dps-dial-increment)
xmap g<C-x> g<Plug>(dps-dial-decrement)
]]

util.map('n', '<Leader>h', ':<C-u>HopWord<CR>', { silent = true })
util.map('n', '<Leader>H', ':<C-u>HopPattern<CR>', { silent = true })
util.map('n', '<Leader>L', ':<C-u>HopLineStart<CR>', { silent = true })

util.map('n', '<Space>u', ':UndotreeToggle<CR>', { silent = true })
