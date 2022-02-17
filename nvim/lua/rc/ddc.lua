local sources = { 'around', 'buffer', 'file', 'vsnip', 'zsh', 'nvim-lsp' }
vim.fn['ddc#custom#patch_global']('sources', sources)
vim.fn['ddc#custom#patch_global']('sourceOptions', {
  _ = {
    matchers = { 'matcher_fuzzy' },
    sourters = { 'sorter_fuzzy' },
    converters = { 'converter_fuzzy' }
  }
})

local source_marks = {
  around = 'A',
  buffer = 'B',
  file = 'F',
  vsnip = 'VS',
  zsh = 'Z'
}
source_marks['nvim-lsp'] = 'LSP'
local source_options = {}

for key, value in pairs(source_marks) do
  source_options[key] = {mark = value}
end

vim.fn['ddc#custom#patch_global']('sourceOptions', source_options)

local lsp_kind = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "ﰠ",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "塞",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "פּ",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

local lsp_params = {}
lsp_params['nvim-lsp'] = { kindLabels = lsp_kind }
vim.fn['ddc#custom#patch_global']('sourceParams', lsp_params)
vim.fn['ddc#custom#patch_global']('completionMenu', 'pum.vim')
vim.cmd[[autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)]]

vim.cmd[[
inoremap <silent><expr> <TAB>
\ ddc#map#pum_visible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#map#manual_complete()
inoremap <expr><S-TAB>  ddc#map#pum_visible() ? '<C-p>' : '<C-h>'
inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
]]

vim.fn['ddc#enable']()

