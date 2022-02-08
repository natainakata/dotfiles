vim.cmd('packadd packer.nvim')
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')

return require('packer').startup(function()
  use('wbthomason/packer.nvim')
  use('vim-jp/vimdoc-ja')
  -- runtime
  use('vim-denops/denops.vim')
  use { 'nvim-lua/popup.nvim' }
  use { 'nvim-lua/plenary.nvim' }
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
      "nvim-telescope/telescope-frecency.nvim",
      "tami5/sqlite.lua",
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
  use { 'lewis6991/gitsigns.nvim' }
    -- task runner
  use('thinca/vim-quickrun')
  use { 'tpope/vim-dispatch' }
  use { 'janko-m/vim-test' }
  -- completion
  use{
    'Shougo/ddc.vim',
    requires = {
      'Shougo/pum.vim',
      'Shougo/ddc-around',
      'Shougo/ddc-nvim-lsp',
      'matsui54/ddc-buffer',
      'LumaKernel/ddc-file',
      'tani/ddc-fuzzy',
      'hrsh7th/vim-vsnip',
      'hrsh7th/vim-vsnip-integ',
      'rafamadriz/friendly-snippets',
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
  -- comment toggle
  use('tpope/vim-commentary')
  -- surrounds
  use('machakann/vim-sandwich')
  -- auto pairs
  use('cohama/lexima.vim')
  -- easymotion
  use{ 'phaazon/hop.nvim' }
  -- root change
  use('mattn/vim-findroot')
  -- yank highlight
  use('machakann/vim-highlightedyank')
  -- colorizer
  use { 'norcalli/nvim-colorizer.lua' }
  -- extend C-a C-x
  use { 'monaqa/dps-dial.vim' }
  -- editorconfig
  use { 'sgur/vim-editorconfig' }
  -- whitespace delete
  use { 'bronson/vim-trailing-whitespace' }
  -- undotree
  use { 'mbbill/undotree' }
end)
