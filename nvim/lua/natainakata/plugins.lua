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

jetpack.add {
  -- manager
  { 'tani/vim-jetpack', opt = 1 },
  -- runtime
  'kyazdani42/nvim-web-devicons',
  'nvim-lua/plenary.nvim',

  -- colorscheme
  'EdenEast/nightfox.nvim',

  -- statusline
  'nvim-lualine/lualine.nvim',
  'akinsho/nvim-bufferline.lua',

  -- language server
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',

  'folke/trouble.nvim',
  'glepnir/lspsaga.nvim',

  -- compilation
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/vim-vsnip',
  'onsails/lspkind-nvim',

  -- syntax highlight
  { 'nvim-treesitter/nvim-treesitter', run = function() require('nvim-treesitter.install').update({ with_sync = true }) end},
  'yioneko/nvim-yati',
  'romgrk/nvim-treesitter-context',
  'p00f/nvim-ts-rainbow',
  'machakann/vim-highlightedyank',
  'nvim-treesitter/nvim-treesitter-textobjects',

  -- finder
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-file-browser.nvim',
  'tami5/sqlite.lua' ,
  'nvim-telescope/telescope-frecency.nvim',
  --  'kyazdani42/nvim-tree.lua'
  'lambdalisue/fern.vim',
  'lambdalisue/fern-git-status.vim',
  'lambdalisue/nerdfont.vim',
  'lambdalisue/fern-renderer-nerdfont.vim',
  'lambdalisue/fern-hijack.vim',

  -- terminal
  { 'akinsho/toggleterm.nvim', tag = '*' },

  -- git support
  'lewis6991/gitsigns.nvim',
  'dinhhuy258/git.nvim',

  -- helper
  'folke/which-key.nvim',

  -- register
  'tversteeg/registers.nvim',

  -- auto pairs
  'cohama/lexima.vim',

  -- comment toggle
  'tpope/vim-commentary',

  -- easymotion
  'phaazon/hop.nvim',

  -- surrounds
  'machakann/vim-sandwich',

  -- colorizer
  'norcalli/nvim-colorizer.lua',

  -- editorconfig
  'sgur/vim-editorconfig',

  -- scrollbar
  'petertriho/nvim-scrollbar',

  -- zenscript
  'DaeZak/crafttweaker-vim-highlighting',

  -- highlight search
  'kevinhwang91/nvim-hlslens',

  -- execute
  'thinca/vim-quickrun',

  -- markdown
  { "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end, },
}
