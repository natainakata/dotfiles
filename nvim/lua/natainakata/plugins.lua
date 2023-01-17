local fn = vim.fn
local jetpackfile = fn.stdpath('data') .. '/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
local jetpackurl = 'https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim'
if fn.filereadable(jetpackfile) == 0 then
  fn.system('curl -fsSLo ' .. jetpackfile .. ' --create-dirs ' .. jetpackurl)
  vim.cmd [[packadd vim-jetpack]]
else 
  vim.cmd [[packadd vim-jetpack]]
end
-- local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
-- if fn.empty(fn.glob(install_path)) > 0 then
--   fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
--   vim.cmd [[packadd packer.nvim]]
-- end

local status, jetpack = pcall(require, 'jetpack.packer')
if (not status) then
  print("Jetpack is not installed")
  return
end

jetpack.startup(function(use)
  -- manager
  use { 'tani/vim-jetpack', opt = 1 }
  -- runtime
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lua/plenary.nvim'

  -- colorscheme
  use 'EdenEast/nightfox.nvim'

  -- statusline
  use 'nvim-lualine/lualine.nvim'
  use 'akinsho/nvim-bufferline.lua'

  -- language server
  use { 'neovim/nvim-lspconfig', requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim'
    },
  }
  use 'folke/trouble.nvim'
  use 'glepnir/lspsaga.nvim'

  -- compilation
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/vim-vsnip'
  use 'onsails/lspkind-nvim'

  -- syntax highlight
  use { 'nvim-treesitter/nvim-treesitter', run = function() require('nvim-treesitter.install').update({ with_sync = true }) end}
  use 'yioneko/nvim-yati'
  use 'romgrk/nvim-treesitter-context'
  use 'p00f/nvim-ts-rainbow'
  use 'machakann/vim-highlightedyank'
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- finder
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use { 'nvim-telescope/telescope-frecency.nvim', requires = { 'tami5/sqlite.lua' } }
  -- use 'kyazdani42/nvim-tree.lua'
  use 'lambdalisue/fern.vim'
  use 'lambdalisue/fern-git-status.vim'
  use { 'lambdalisue/fern-renderer-nerdfont.vim', requires = { 'lambdalisue/nerdfont.vim' } }
  use 'lambdalisue/fern-hijack.vim'

  -- terminal
  use { 'akinsho/toggleterm.nvim', tag = 'v2.*' }

  -- git support
  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim'

  -- helper
  use 'folke/which-key.nvim'

  -- register
  use 'tversteeg/registers.nvim'

  -- auto pairs
  use 'cohama/lexima.vim'

  -- comment toggle
  use 'tpope/vim-commentary'

  -- easymotion
  use 'phaazon/hop.nvim'

  -- surrounds
  use 'machakann/vim-sandwich'

  -- colorizer
  use 'norcalli/nvim-colorizer.lua'

  -- editorconfig
  use 'sgur/vim-editorconfig'

  -- scrollbar
  use 'petertriho/nvim-scrollbar'

  -- zenscript
  use 'DaeZak/crafttweaker-vim-highlighting'

  -- highlight search
  use 'kevinhwang91/nvim-hlslens'

  -- execute
  use 'thinca/vim-quickrun'
  -- markdown
  use { "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end, }
end)
