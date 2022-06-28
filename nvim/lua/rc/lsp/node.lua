local nvim_lsp = require('lspconfig')
local M = {}

M.root_dir = nvim_lsp.util.root_pattern("package.json")

return M
