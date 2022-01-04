" maps

nnoremap j gj
nnoremap k gk

" map prefix
let g:mapleader = "\<Space>"
nnoremap <Leader> <Nop>
xnoremap <Leader> <Nop>

nnoremap <Leader>w :w<CR>
inoremap <silent> jj <Esc>

" Terminal
nnoremap <silent> <Leader>t :Tnew<CR>
tnoremap <Esc> <C-\><C-n>
nmap <silent> <Leader><Leader>p :let @* = expand("%")<CR>

