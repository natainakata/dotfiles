local keymap = vim.keymap

keymap.set('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- general keymap
keymap.set('n', 'j', 'gj')
keymap.set('n', 'gj', 'j')
keymap.set('n', 'k', 'gk')
keymap.set('n', 'gk', 'k')
keymap.set('n', 'U', '<C-r>')
keymap.set('n', '<Leader>w', ':w<CR>')
keymap.set('i', 'jj', '<Esc>')
keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR>')
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- window and buffer
keymap.set('n', 'gl', ':bnext<CR>')
keymap.set('n', 'gh', ':bprevious<CR>')
keymap.set('n', 'gH', ':blast<CR>')
keymap.set('n', 'gL', ':bfirst<CR>')
keymap.set('n', 'gs', ':split<CR><C-w>w')
keymap.set('n', 'te', ':tabedit')
keymap.set('n', 'gv', ':vsplit<CR><C-w>w')

keymap.set('n', '<C-h>', '<Cmd>wincmd h<CR>')
keymap.set('n', '<C-j>', '<Cmd>wincmd j<CR>')
keymap.set('n', '<C-k>', '<Cmd>wincmd k<CR>')
keymap.set('n', '<C-l>', '<Cmd>wincmd l<CR>')

keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')

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

keymap.set('n', '<Leader>D', ':BufferDeleteSafety<CR>')

-- fold
keymap.set('n', 'Z', ':set foldmethod=indent<CR>')

-- fern
keymap.set('n', '<Leader>e', '<Cmd>Fern . -reveal=% -drawer -toggle<CR>')

