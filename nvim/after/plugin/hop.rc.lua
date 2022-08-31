local status, hop = pcall(require, 'hop')
if (not status) then return end

hop.setup()

vim.keymap.set('n', '<Leader>h', ':<C-u>HopWord<CR>')
vim.keymap.set('n', '<Leader>H', ':<C-u>HopPattern<CR>')
vim.keymap.set('n', '<Leader>L', ':<C-u>HopLineStart<CR>')
