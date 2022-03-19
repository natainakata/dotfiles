local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- general keymap
keymap('n', 'j', 'gj', opts)
keymap('n', 'gj', 'j', opts)
keymap('n', 'k', 'gk', opts)
keymap('n', 'gk', 'k', opts)
keymap('n', 'U', '<C-r>', opts)
keymap('n', '<Leader>w', ':w<CR>', opts)
keymap('i', 'jj', '<Esc>', opts)
keymap('n', '<Esc><Esc>', ':nohlsearch<CR>', opts)

-- window and buffer
keymap('n', 'gl', ':bnext<CR>', opts)
keymap('n', 'gh', ':bprevious<CR>', opts)
keymap('n', 'gH', ':blast<CR>', opts)
keymap('n', 'gL', ':bfirst<CR>', opts)

-- fold
keymap('n', 'Z', ':set foldmethod=indent<CR>', opts)

-- session
keymap('n', '<Leader>ss', ':<C-u>SessionSave<CR>', opts)
keymap('n', '<Leader>sl', ':<C-u>SessionLoad<CR>', opts)

-- dps-dial
vim.cmd[[
nmap  <C-a>  <Plug>(dps-dial-increment)
nmap  <C-x>  <Plug>(dps-dial-decrement)
xmap  <C-a>  <Plug>(dps-dial-increment)
xmap  <C-x>  <Plug>(dps-dial-decrement)
xmap g<C-a> g<Plug>(dps-dial-increment)
xmap g<C-x> g<Plug>(dps-dial-decrement)
]]

-- hop
keymap('n', '<Leader>h', ':<C-u>HopWord<CR>', opts)
keymap('n', '<Leader>H', ':<C-u>HopPattern<CR>', opts)
keymap('n', '<Leader>L', ':<C-u>HopLineStart<CR>', opts)

-- undotree
keymap('n', '<Space>u', ':UndotreeToggle<CR>', opts)
keymap('n', '<Space>r', ':QuickRun<CR>', opts)

-- sandwich
vim.cmd[[
  nmap <silent>ys <Plug>(operator-sandwich-add)
  nmap <silent>ds <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
  nmap <silent>cs <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
]]
