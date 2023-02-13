local status, noice = pcall(require, 'noice')
if (not status) then return end
if not vim.g.neovide then
  noice.setup()
end


