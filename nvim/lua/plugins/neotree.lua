local status, neotree = pcall(require, 'neo-tree')
if (not status) then return end

neotree.setup({
  filesystem = {
    hijack_netrw_behavior = "open_default",
  }
})


local keymap = vim.keymap
keymap.set('n', '<Leader>e', '<Cmd>Neotree<CR>')

