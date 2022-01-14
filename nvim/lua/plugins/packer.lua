local util = require('utils')
vim.cmd('packadd packer.nvim')
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')

return require('packer').startup(function()
  use('wbthomason/packer.nvim')
  use('vim-jp/vimdoc-ja')
  -- runtime
  use('vim-denops/denops.vim')
  -- icons
  use('kyazdani42/nvim-web-devicons')
  use('lambdalisue/nerdfont.vim')
  -- fuzzy finder
  use { 
    'nvim-telescope/telescope.nvim',
    requires = {{ 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' }}
  }
    use('nvim-telescope/telescope-github.nvim')
    use('nvim-telescope/telescope-ghq.nvim')
    use('sudormrfbin/cheatsheet.nvim')
    -- project management
    use('ahmedkhalf/project.nvim')
  -- file explorer
  use('lambdalisue/fern.vim')
  use('lambdalisue/fern-renderer-nerdfont.vim')
  use('lambdalisue/fern-git-status.vim')
  use('yuki-yano/fern-preview.vim')
  use('lambdalisue/fern-hijack.vim')
  -- git support
  use('lambdalisue/gina.vim')
  use('airblade/vim-gitgutter')
  -- comment toggle
  use('tpope/vim-commentary')
  -- surrounds
  use('machakann/vim-sandwich')
  -- auto pairs
  use('cohama/lexima.vim')
  -- easymotion
  use('phaazon/hop.nvim')
  -- task runner
  use('thinca/vim-quickrun')
  -- completion
  use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/vim-vsnip')
    use('hrsh7th/vim-vsnip-integ')
    use('rafamadriz/friendly-snippets')
    use('hrsh7th/cmp-vsnip')
  -- builtin lsp
  use('neovim/nvim-lspconfig')
  use('williamboman/nvim-lsp-installer')
  -- which key
  use('folke/which-key.nvim')
  -- statusline and bufferline
  use('romgrk/barbar.nvim')
  use('nvim-lualine/lualine.nvim')
  -- terminal
  use('voldikss/vim-floaterm')
  -- notify
  use('rcarriga/nvim-notify')
  -- yank highlight
  use('machakann/vim-highlightedyank')
  -- treesitter
  use{'nvim-treesitter/nvim-treesitter', run = [[:TSUpdate]]}
  -- colorscheme
  use('RRethy/nvim-base16')
  use('folke/tokyonight.nvim')
end)


