local keymap = vim.keymap

keymap.set('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
local opts = { silent = true }

-- general keymap
keymap.set('n', 'j', 'gj')
keymap.set('n', 'gj', 'j')
keymap.set('n', 'k', 'gk')
keymap.set('n', 'gk', 'k')
keymap.set('n', 'U', '<C-r>')
keymap.set('n', '<Leader>w', ':w<CR>', opts)
keymap.set('i', 'jj', '<Esc>')
keymap.set('n', ';', ':')
keymap.set('n', ':', ';')
    keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR>', opts)

-- window and buffer
keymap.set('n', 'gl', ':bnext<CR>', opts)
keymap.set('n', 'gh', ':bprevious<CR>', opts)
keymap.set('n', 'gH', ':blast<CR>', opts)
keymap.set('n', 'gL', ':bfirst<CR>', opts)
keymap.set('n', 'gs', ':split<CR><C-w>w', opts)
keymap.set('n', 'te', ':tabedit', opts)
keymap.set('n', 'gv', ':vsplit<CR><C-w>w', opts)

keymap.set('n', '<C-h>', '<Cmd>wincmd h<CR>', {remap = true})
keymap.set('n', '<C-j>', '<Cmd>wincmd j<CR>', {remap = true})
keymap.set('n', '<C-k>', '<Cmd>wincmd k<CR>', {remap = true})
keymap.set('n', '<C-l>', '<Cmd>wincmd l<CR>', {remap = true})

keymap.set('n', '<C-w><left>', '<C-w><', {remap = true})
keymap.set('n', '<C-w><right>', '<C-w>>', {remap = true})
keymap.set('n', '<C-w><up>', '<C-w>+', {remap = true})
keymap.set('n', '<C-w><down>', '<C-w>-', {remap = true})

vim.api.nvim_create_user_command(
  'BufferDeleteSafety',
  function()
    if vim.fn['input']('delete buffer? (y/N): ') == 'y' then
      vim.cmd[[
        redraw
        bdelete!
      ]]
      print('delete buffer!')
    end
  end,
  { nargs = 0 }
)

keymap.set('n', '<Leader>D', ':BufferDeleteSafety<CR>', opts)

-- fold
keymap.set('n', 'Z', ':set foldmethod=indent<CR>', opts)

-- fern
-- keymap.set('n', '<Leader>e', '<Cmd>Fern . -reveal=% -drawer -toggle<CR>')

-- quickrun
keymap.set('n', '<Leader>R', '<Cmd>QuickRun<CR>', opts)

local mapsgroup = vim.api.nvim_create_augroup('MapsGroup', {
  clear = true
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'quickrun',
  callback = function ()
    vim.keymap.set('n', 'q', '<Cmd>quit<CR>', { buffer = true, silent = true})
  end,
  group = mapsgroup
})

-- cmdwin
vim.api.nvim_create_autocmd({ 'CmdwinEnter' },
  {
    pattern = '*',
    callback = function ()
      vim.keymap.set('n', 'q', '<Cmd>quit<CR>', { buffer = true, silent = true })
    end,
    group = mapsgroup,
  }
)
