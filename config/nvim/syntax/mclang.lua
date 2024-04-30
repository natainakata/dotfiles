vim.cmd([[syntax region value start=/=/ms=e+1 end=/\n/]])
local set_hl = vim.api.nvim_set_hl

set_hl(0, "value", { link = "String" })

vim.b.current_syntax = "mclang"
