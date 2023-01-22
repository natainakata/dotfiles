local status, noice = pcall(require, 'noice')
if (not status) then return end

if (vim.fn.exists('g:neovide') ~= 1) then
  noice.setup({})
end

