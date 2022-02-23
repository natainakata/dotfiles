local util = require('utils')
vim.fn['ddu#custom#patch_global']({
  ui = 'ff',
  uiParams = {
    ff = {
      prompt = ">",
      displaySourceName = "short",
      reversed = true,
      startFilter = true,
      previewVertical = true,

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
  sourceParams = {
    file_rec = {
      ignoredDirectories = {
        '.git', '.vscode-server', '.cache'
      }
    }
  },
  sourceOptions = {
    _ = {
      matchers = { 'matcher_fzf' }
    },
  },
  kindOptions = {
    file = {
      defaultAction = 'open'
    },
    action = {
      defaultAction = 'do'
    }
  }
})

vim.cmd[[
nnoremap <silent> <Leader>b <Cmd>call ddu#start({'sources': [{'name': 'buffer'}]})<CR>
nnoremap <silent> <Leader>f <Cmd>call ddu#start({'sources': [{'name': 'file_rec'}]})<CR>
nnoremap <silent> <Leader>o <Cmd>call ddu#start({'sources': [{'name': 'mr'}]})<CR>
nnoremap <silent> <Leader>/ <Cmd>DduRg<CR>
]]
