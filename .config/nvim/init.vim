call plug#begin(stdpath('data') . '/plugged')
  Plug 'vim-jp/vimdoc-ja'
  Plug 'vim-denops/denops.vim'
  Plug 'nvim-telescope/telescope.nvim' | Plug 'nvim-lua/plenary.nvim'
    Plug 'xiyaowong/telescope-emoji.nvim'
    Plug 'nvim-telescope/telescope-project.nvim'
    Plug 'nvim-telescope/telescope-github.nvim'
    Plug 'nvim-telescope/telescope-ghq.nvim'
    Plug 'sudormrfbin/cheatsheet.nvim' | Plug 'nvim-lua/popup.nvim'
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/fern.vim'
    Plug 'yuki-yano/fern-preview.vim'
    Plug 'lambdalisue/fern-git-status.vim'
    Plug 'lambdalisue/fern-hijack.vim'
    Plug 'lambdalisue/fern-renderer-nerdfont.vim'
    Plug 'lambdalisue/glyph-palette.vim'
  Plug 'tamago324/lir.nvim'
  Plug 'Shougo/ddc.vim' | Plug 'Shougo/pum.vim'
    Plug 'Shougo/ddc-matcher_head'
    Plug 'Shougo/ddc-matcher_length'
    Plug 'Shougo/ddc-sorter_rank'
    Plug 'Shougo/ddc-around'
    Plug 'LumaKernel/ddc-file'
    Plug 'Shougo/ddc-converter_remove_overlap'
    Plug 'Shougo/ddc-rg'
    Plug 'Shougo/ddc-cmdline'
    Plug 'Shougo/ddc-cmdline-history'
    Plug 'Shougo/neco-vim'
  Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'shun/ddc-vim-lsp'
  Plug 'lambdalisue/gina.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'machakann/vim-sandwich'
  Plug 'cohama/lexima.vim'
  Plug 'tpope/vim-commentary'
  Plug 'easymotion/vim-easymotion'
  Plug 'kassio/neoterm'
  Plug 'thinca/vim-quickrun'
  Plug 'AckslD/nvim-neoclip.lua'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'alker0/chezmoi.vim'
  Plug 'machakann/vim-highlightedyank'
  Plug 'sainnhe/gruvbox-material'
  Plug 'morhetz/gruvbox' 
  Plug 'projekt0n/github-nvim-theme'
  Plug 'sainnhe/sonokai'
  Plug 'tanvirtin/monokai.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'akinsho/bufferline.nvim'
call plug#end()
let g:python3_host_prog = system('echo -n $(which python3)')

let s:plugs = get(s:, 'plugs', get(g:, 'plugs', {}))
function! FindPlugin(name) abort
  return has_key(s:plugs, a:name) ? isdirectory(s:plugs[a:name].dir) : 0
endfunction
command! -nargs=1 UsePlugin if !FindPlugin(<args>) | finish | endif

runtime! rc/*.vim
runtime! plugins/*.vim
