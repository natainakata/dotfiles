local util = require('utils')
vim.cmd('packadd packer.nvim')
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')

return require('packer').startup(function()
  use('wbthomason/packer.nvim')
  use('vim-jp/vimdoc-ja')
  -- runtime
  use('vim-denops/denops.vim')
  -- icons
  use{'kyazdani42/nvim-web-devicons'}
  use{'lambdalisue/nerdfont.vim'}
  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 
      'nvim-lua/popup.nvim', 
      'nvim-lua/plenary.nvim', 
      'nvim-telescope/telescope-github.nvim', 
      'nvim-telescope/telescope-ghq.nvim', 
      'nvim-telescope/telescope-project.nvim',
      'sudormrfbin/cheatsheet.nvim', 
      'LinArcx/telescope-command-palette.nvim',
      'fhill2/telescope-ultisnips.nvim',
    },
  }
  -- file explorer
  use{
    'lambdalisue/fern.vim',
    requires = {
      'lambdalisue/fern-renderer-nerdfont.vim',
      'lambdalisue/fern-git-status.vim',
      'yuki-yano/fern-preview.vim',
      'lambdalisue/fern-hijack.vim',
    },
  }
  -- git support
  use('lambdalisue/gina.vim')
  use('airblade/vim-gitgutter')
    -- task runner
  use('thinca/vim-quickrun')
  -- completion
  use{
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'SirVer/ultisnips',
      'honza/vim-snippets',
      'quangnguyen30192/cmp-nvim-ultisnips',
      'neovim/nvim-lspconfig',
      'williamboman/nvim-lsp-installer',
    },
  }
    -- which key
  use('folke/which-key.nvim')
  -- statusline and bufferline
  use('romgrk/barbar.nvim')
  use('nvim-lualine/lualine.nvim')
  -- terminal
  use('voldikss/vim-floaterm')
  -- notify
  use('rcarriga/nvim-notify')
  -- dashboard
  use('glepnir/dashboard-nvim')
  -- treesitter
  use{'nvim-treesitter/nvim-treesitter', run = [[:TSUpdate]]}
  -- colorscheme
  use('RRethy/nvim-base16')
  use('folke/tokyonight.nvim')
-- comment toggle
  use('tpope/vim-commentary')
  -- surrounds
  use('machakann/vim-sandwich')
  -- auto pairs
  use('cohama/lexima.vim')
  -- easymotion
  use('phaazon/hop.nvim')
  -- root change
  use('mattn/vim-findroot')
  -- yank highlight
  use('machakann/vim-highlightedyank')
  -- colorizer
  use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end}
  -- extend C-a C-x
  use { 'monaqa/dps-dial.vim' }
  -- extend n
  use { 'osyo-manga/vim-anzu' }

end)
