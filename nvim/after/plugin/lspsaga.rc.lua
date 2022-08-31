local status, saga = pcall(require, 'lspsaga')
if (not status) then return end

saga.init_lsp_saga({})

vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>')
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>')
vim.keymap.set('n', '<Leader>lf', '<Cmd>Lspsaga lsp_finder<CR>')
vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>')
vim.keymap.set('n', '<Leader>lp', '<Cmd>Lspsaga preview_definition<CR>')
vim.keymap.set('n', '<F2>', '<Cmd>Lspsaga rename<CR>')
