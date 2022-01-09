local util = require('utils')
local opts = { silent = true }

util.map('n', 'gT', ':BufferPrevious<CR>', opts)
util.map('n', 'gt', ':BufferNext<CR>', opts)
