local util = require('utils')
vim.fn['ddu#custom#patch_global']({
  ui = 'ff',
  uiParams = {
    ff = {
      previewFloating = true,
      prompt = ">",
    }
  },
  sources = {
    {name = 'file_rec', params = {}},
--     {name = 'nvim-lsp', params = {}},
    {name = 'mr', params = {}},
    {name = 'buffer', params = {}},
    {name = 'rg', params = {}},
    {name = 'line', params = {}}
  },
  sourceOptions = {
    _ = {
      matchers = { 'matcher_substring' }
    },
  },
  kindOptions = {
    file = {
      defaultAction = 'open'
    },
  }
})

vim.cmd[[
nnoremap <silent> <Leader>b <Cmd>call ddu#start({'sources': [{'name': 'buffer'}]})<CR>
nnoremap <silent> <Leader>f <Cmd>call ddu#start({'sources': [{'name': 'file_rec'}]})<CR>
nnoremap <silent> <Leader>o <Cmd>call ddu#start({'sources': [{'name': 'mr'}]})<CR>
nnoremap <silent> <Leader>/ <Cmd>call ddu#start({'sources': [{'name': 'rg'}]})<CR>
]]
