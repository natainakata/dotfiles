" set options
set fenc=utf-8
set nobackup
set noswapfile
set laststatus=2
set expandtab
set smartindent
set tabstop=2
set shiftwidth=2

set hlsearch
set incsearch
set smartcase
set wrapscan
nmap <Esc><Esc> :nohlsearch<CR><Esc>

if has('persistent_undo')
  let undo_path = expand('~/.vim/undo')
  exe 'set undodir=' .. undo_path
  set undofile
endif

set number
set termguicolors
set cursorline
set cursorcolumn
set visualbell
set showmatch
set wildmode=list:longest

set virtualedit=onemore

set mouse=a

  set clipboard^=unnamedplus

let g:neoterm_autoinsert = 1
let g:neoterm_default_mod = 'botright'
