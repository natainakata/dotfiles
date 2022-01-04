UsePlugin 'telescope.nvim'

nnoremap [ff] <Nop>
xnoremap [ff] <Nop>
nmap <Leader>f [ff]
xmap <Leader>f [ff]

nnoremap <silent> <C-p> <cmd>Telescope find_files hidden=true<CR>
nnoremap <silent> [ff]p <cmd>Telescope project<CR>
nnoremap <silent> [ff]p <cmd>Telescope project<CR>
nnoremap <silent> [ff]c <cmd>Telescope commands<CR>
nnoremap <silent> [ff]C :Cheatsheet<CR>
nnoremap <silent> [ff]T <cmd>Telescope colorscheme<CR>
nnoremap <silent> [ff]/ <cmd>Telescope live_grep<CR>
nnoremap <silent> [ff]b <cmd>Telescope buffers<CR>
nnoremap <silent> [ff]t <cmd>Telescope builtin<CR>
nnoremap <silent> [ff]h <cmd>Telescope help_tags<CR>
nnoremap <silent> [ff]f <cmd>Telescope git_files hidden=true<CR>
nnoremap <silent> [ff]s <cmd>Telescope git_status<CR>
nnoremap <silent> [ff]B <cmd>Telescope git_branches<CR>

lua <<EOF
require 'telescope'.load_extension('project')
require 'telescope'.load_extension('gh')
require 'telescope'.load_extension('ghq')
require 'telescope'.setup {
}


EOF
