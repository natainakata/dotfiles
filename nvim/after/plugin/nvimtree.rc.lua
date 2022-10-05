local status, tree = pcall(require, 'nvim-tree')
if (not status) then return end
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1


tree.setup({
  view = {
    mappings = {
      list = {
        { key = '?', action = 'toggle_help' },
        { key = 'h', action = 'dir_up' },
        { key = 'l', action = 'edit' }
      }
    }
  }
})

vim.keymap.set('n', '<Leader>E', ':NvimTreeToggle<CR>');
