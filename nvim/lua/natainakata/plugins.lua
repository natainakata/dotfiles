local fn = vim.fn
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- local jetpackfile = fn.stdpath('data') .. '/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
-- local jetpackurl = 'https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim'
-- if fn.filereadable(jetpackfile) == 0 then
--   fn.system('curl -fsSLo ' .. jetpackfile .. ' --create-dirs ' .. jetpackurl)
--   vim.cmd [[packadd vim-jetpack]]
-- else
--   vim.cmd [[packadd vim-jetpack]]
-- end
-- local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
-- if fn.empty(fn.glob(install_path)) > 0 then
--   fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
--   vim.cmd [[packadd packer.nvim]]
-- end

local status, lazy = pcall(require, 'lazy')
if (not status) then
  print("Lazy is not installed")
  return
end

lazy.setup({
  -- manager
  -- { 'tani/vim-jetpack', opt = 1 },
  -- runtime
  'nvim-lua/plenary.nvim',
  'nvim-lua/popup.nvim',
  'MunifTanjim/nui.nvim',
  'vim-jp/vimdoc-ja',
  'rcarriga/nvim-notify',

  -- colorscheme
  'EdenEast/nightfox.nvim',
  'tanvirtin/monokai.nvim',

  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' }
  },
  {
    'akinsho/nvim-bufferline.lua',
    dependencies = { 'kyazdani42/nvim-web-devicons' }
  },

  -- language server
  { 'williamboman/mason.nvim', dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason-lspconfig.nvim',
      'folke/trouble.nvim',
      'glepnir/lspsaga.nvim',
    }
  },

  -- compilation
  { 'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/vim-vsnip',
      'onsails/lspkind-nvim',
    }
  },

  -- syntax highlight
  { 'nvim-treesitter/nvim-treesitter',
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    dependencies = {
      'yioneko/nvim-yati',
      'romgrk/nvim-treesitter-context',
      'p00f/nvim-ts-rainbow',
      'nvim-treesitter/nvim-treesitter-textobjects',
    }
  },
  -- finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-telescope/telescope-file-browser.nvim',
      'tami5/sqlite.lua' ,
      'nvim-telescope/telescope-frecency.nvim',
      'kyazdani42/nvim-web-devicons',
    }
  },

  -- explorer
  --  'kyazdani42/nvim-tree.lua'
  -- 'lambdalisue/fern.vim',
  -- 'lambdalisue/fern-git-status.vim',
  -- 'lambdalisue/nerdfont.vim',
  -- 'lambdalisue/fern-renderer-nerdfont.vim',
  -- 'lambdalisue/fern-hijack.vim',
  { 'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    keys = {
      { '<Leader>e', '<Cmd>Neotree<CR>', desc = 'Neotree' }
    }
  },

  -- terminal
  'akinsho/toggleterm.nvim',

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

  -- highlight yank
  'machakann/vim-highlightedyank',

  -- execute
  'thinca/vim-quickrun',

  -- markdown
  { "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end, },

  -- startup
  'goolord/alpha-nvim',

  -- repl
  'hkupty/iron.nvim',
})
