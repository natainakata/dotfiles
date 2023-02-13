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
keymap.set({'n', 'i', 'v', 's'}, '<C-s>', ':w<CR><Esc>', opts)
keymap.set('i', 'jj', '<Esc>')
keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR>', opts)
keymap.set('n', '<Leader>qq', '<Cmd>qa<cr>', opts)

-- window and buffer
keymap.set('n', 'gs', '<Cmd>split<CR><C-w>w', opts)
keymap.set('n', 'gv', '<Cmd>vsplit<CR><C-w>w', opts)

keymap.set('n', 'g<tab><tab>', '<Cmd>tabnew<CR>', opts)
keymap.set('n', 'g<tab>h', '<Cmd>tabprevious<CR>', opts)
keymap.set('n', 'g<tab>l', '<Cmd>tabnext<CR>', opts)
keymap.set('n', 'g<tab>d', '<Cmd>tabclose<CR>', opts)

keymap.set('n', '<C-h>', '<Cmd>wincmd h<CR>', {remap = true})
keymap.set('n', '<C-j>', '<Cmd>wincmd j<CR>', {remap = true})
keymap.set('n', '<C-k>', '<Cmd>wincmd k<CR>', {remap = true})
keymap.set('n', '<C-l>', '<Cmd>wincmd l<CR>', {remap = true})

keymap.set('n', '<C-Up>', '<Cmd>resize +2<CR>', {remap = true})
keymap.set('n', '<C-Down>', '<Cmd>resize -2<CR>', {remap = true})
keymap.set('n', '<C-Left>', '<Cmd>vertical resize -2<CR>', {remap = true})
keymap.set('n', '<C-Right>', '<Cmd>vertical resize +2<CR>', {remap = true})

vim.api.nvim_create_user_command(
  'BufferDeleteSafety',
  function()
    if vim.fn['input']("delete buffer? (y/N): ") == 'y' then
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

local mapsgroup = vim.api.nvim_create_augroup('MapsGroup', {
  clear = true
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

local function reloadConfig()
  for name,_ in pairs(package.loaded) do
    if name:match('^natainakata') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

vim.keymap.set('n', '<Leader>R', function() reloadConfig() end)
