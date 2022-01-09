local util = {}

util.opt = vim.opt
util.fn = vim.fn
util.g = vim.g
util.map = function (mode, lhs, rhs, opts) 
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
util.bufmap = function (buf, mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_buf_set_keymap(buf, mode, lhs, rhs, options)
end

return util
