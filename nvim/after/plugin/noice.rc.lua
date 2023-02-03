local status, noice = pcall(require, 'noice')
if (not status) then return end

if not (vim.fn.exists('g:goneovim') == 1 or string.find(vim.v.servername, 'localhost:') ~= nil ) then
  noice.setup({})
end

