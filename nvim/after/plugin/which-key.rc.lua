local status, whichKey = pcall(require, 'which-key')
if (not status) then return end
whichKey.setup{
  window = {
    border = "double",
  }
}
