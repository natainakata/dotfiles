local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd('packadd packer.nvim')
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')

return require('packer').startup(function(use)
  use'wbthomason/packer.nvim'
  use'vim-jp/vimdoc-ja'
  -- runtime
  use'vim-denops/denops.vim'
  use'nvim-lua/popup.nvim'
  use'nvim-lua/plenary.nvim'
  -- mru
  use'lambdalisue/mr.vim'
  -- icons
  use'kyazdani42/nvim-web-devicons'
  use'lambdalisue/nerdfont.vim'
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
  use {
    'Shougo/ddu.vim',
    requires = {
      'Shougo/ddu-ui-ff',
      'Shougo/ddu-source-file_rec',
      'Shougo/ddu-source-register',
      'shun/ddu-source-buffer',
      'shun/ddu-source-rg',
      'kuuote/ddu-source-mr',
      'gamoutatsumi/ddu-source-nvim-lsp',
      'Shougo/ddu-source-action',
      'yuki-yano/ddu-filter-fzf',
      'Shougo/ddu-filter-matcher_substring',
      'Shougo/ddu-kind-file'
    }
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
  use'kyazdani42/nvim-tree.lua'
   -- git support
  use'lambdalisue/gina.vim'
  use'lewis6991/gitsigns.nvim'
    -- task runner
  use'thinca/vim-quickrun'
  use'tpope/vim-dispatch'
  use'janko-m/vim-test'
  -- completion
  use{
    'Shougo/ddc.vim',
    requires = {
      'Shougo/pum.vim',
      'Shougo/ddc-around',
      'Shougo/ddc-nvim-lsp',
      'matsui54/ddc-buffer',
      'LumaKernel/ddc-file',
      'Shougo/ddc-zsh',
      'tani/ddc-fuzzy',
      'hrsh7th/vim-vsnip',
      'hrsh7th/vim-vsnip-integ',
      'rafamadriz/friendly-snippets',
      'neovim/nvim-lspconfig',
      'williamboman/nvim-lsp-installer',
    },
  }
    -- which key
  use{'folke/which-key.nvim', config = function()
    require('which-key').setup{
      window = {
        border = "double",
      }
    }
  end}
  -- statusline and bufferline
  use { 'akinsho/bufferline.nvim' }
  use'nvim-lualine/lualine.nvim'
  -- register
  use'tversteeg/registers.nvim'
  -- terminal
  use'voldikss/vim-floaterm'
  -- notify
  use'rcarriga/nvim-notify'
  -- dashboard
  use'glepnir/dashboard-nvim'
  -- treesitter
  use {'nvim-treesitter/nvim-treesitter', run = [[:TSUpdate]]}
  -- colorscheme
  -- use('RRethy/nvim-base16')
  use { 'dracula/vim', as = 'dracula' }
  use'projekt0n/github-nvim-theme'
  use'tanvirtin/monokai.nvim'
  -- comment toggle
  use'tpope/vim-commentary'
  -- surrounds
  use'machakann/vim-sandwich'
  -- auto pairs
  use'cohama/lexima.vim'
  -- easymotion
  use{ 'phaazon/hop.nvim', config = function() require('hop').setup() end, }
  -- root change
  use'mattn/vim-findroot'
  -- yank highlight
  use'machakann/vim-highlightedyank'
  -- colorizer
  use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end }
  -- extend C-a C-x
  use'monaqa/dps-dial.vim'
  -- editorconfig
  use'sgur/vim-editorconfig'
  -- whitespace delete
  use'bronson/vim-trailing-whitespace'
  -- markdown
  -- use'tani/glance-vim'
  -- undotree
  use'mbbill/undotree'
  -- init.lua dev
  use { 'folke/lua-dev.nvim' }
end)
