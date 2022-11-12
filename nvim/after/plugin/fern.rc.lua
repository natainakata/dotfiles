local keymap = vim.keymap
vim.g['fern#renderer'] = 'nerdfont'

keymap.set('n', '<Leader>e', '<Cmd>Fern . -reveal=% -drawer -toggle<CR>')

function _G.init_fern()
  local opts = { buffer = 0 }
  keymap.set('n', '<C-h>', '<Cmd>wincmd h<CR>', opts)
  keymap.set('n', '<C-j>', '<Cmd>wincmd j<CR>', opts)
  keymap.set('n', '<C-k>', '<Cmd>wincmd k<CR>', opts)
  keymap.set('n', '<C-l>', '<Cmd>wincmd l<CR>', opts)
end

local fern_custom = vim.api.nvim_create_augroup('fern-custom', {})
vim.api.nvim_create_autocmd({'FileType'}, {
  group = fern_custom,
  pattern = 'fern',
  command = 'lua init_fern()'
})


