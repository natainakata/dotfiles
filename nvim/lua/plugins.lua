local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd('packadd packer.nvim')
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'vim-jp/vimdoc-ja'
  -- runtime
  use 'vim-denops/denops.vim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'MunifTanjim/nui.nvim'
  use 'tami5/sqlite.lua'
  -- mru
  use 'lambdalisue/mr.vim'
  -- icons
  use 'kyazdani42/nvim-web-devicons'
  use 'lambdalisue/nerdfont.vim'
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
      'nvim-telescope/telescope-frecency.nvim',
      'nvim-telescope/telescope-packer.nvim',
      'nvim-telescope/telescope-symbols.nvim',
      'nvim-telescope/telescope-ui-select.nvim'
    },
  }
  -- file explorer
  use {
    'lambdalisue/fern.vim',
    requires = {
      'lambdalisue/fern-renderer-nerdfont.vim',
      'lambdalisue/fern-git-status.vim',
      'yuki-yano/fern-preview.vim',
      'lambdalisue/fern-hijack.vim',
    },
  }
   -- git support
  use 'lambdalisue/gina.vim'
  use 'lewis6991/gitsigns.nvim'
    -- task runner
  use 'thinca/vim-quickrun'
  use 'tpope/vim-dispatch'
  use 'janko-m/vim-test'
  use {'yutkat/taskrun.nvim', config = function() require("taskrun").setup() end}
  -- completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'onsails/lspkind-nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-emoji',
      'f3fora/cmp-spell',
      'hrsh7th/cmp-cmdline',
      'ray-x/cmp-treesitter',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'hrsh7th/vim-vsnip-integ',
    }
  }
  -- lsp
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/nvim-lsp-installer',
    }
  }
  use {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup{}
    end
  }
  use 'jose-elias-alvarez/null-ls.nvim'
  -- which key
  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup{
        window = {
          border = "double",
        }
      }
    end
  }
  -- statusline and bufferline
  use 'akinsho/bufferline.nvim'
  use 'nvim-lualine/lualine.nvim'
  -- search
  use 'kevinhwang91/nvim-hlslens'
  use 'haya14busa/vim-asterisk'
  -- register
  use 'tversteeg/registers.nvim'
  -- terminal
  use 'akinsho/toggleterm.nvim'
  -- notify
  use 'rcarriga/nvim-notify'
  -- dashboard
  use 'glepnir/dashboard-nvim'
  -- treesitter
  use {'nvim-treesitter/nvim-treesitter', run = [[:TSUpdate]]}
  use 'yioneko/nvim-yati'
  use 'romgrk/nvim-treesitter-context'
  use 'p00f/nvim-ts-rainbow'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use { 'mfussenegger/nvim-ts-hint-textobject', config = function() require('tsht').config.hint_keys = { "h", "j", "f", "d", "n", "v", "s", "l", "a" } end }
  -- colorscheme
  use { 'dracula/vim', as = 'dracula' }
  use 'projekt0n/github-nvim-theme'
  use 'tanvirtin/monokai.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'rafamadriz/neon'
  use 'folke/tokyonight.nvim'
  -- comment toggle
  use 'tpope/vim-commentary'
  -- surrounds
  use 'machakann/vim-sandwich'
  -- auto pairs
  use 'cohama/lexima.vim'
  -- easymotion
  use { 'phaazon/hop.nvim', config = function() require('hop').setup() end, }
  use 'unblevable/quick-scope'
  -- root change
  use 'mattn/vim-findroot'
  -- highlight
  use 'machakann/vim-highlightedyank'
  use 't9md/vim-quickhl'
  use 'RRethy/vim-illuminate'
  -- colorizer
  use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end }
  -- extend C-a C-x
  use 'monaqa/dps-dial.vim'
  -- buffer output
  use 'tyru/capture.vim'
  -- mkdir
  use 'jghauser/mkdir.nvim'
  -- editorconfig
  use 'sgur/vim-editorconfig'
  -- whitespace delete
  use 'bronson/vim-trailing-whitespace'
  -- undotree
  use 'mbbill/undotree'
  -- init.lua dev
  use { 'folke/lua-dev.nvim' }
  -- scrollbar
  use 'petertriho/nvim-scrollbar'

  use 'DaeZak/crafttweaker-vim-highlighting'
end)
