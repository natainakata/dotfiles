local nvim_lsp = require('lspconfig')
local M = {}

M.root_dir = nvim_lsp.util.root_pattern("deno.json")
M.init_options = { lint = true, unstable = true, }

return M
