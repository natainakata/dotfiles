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

local status, lazy = pcall(require, 'lazy')
if (not status) then
  print("Lazy is not installed")
  return
end

lazy.setup({
  -- manager
  -- runtime
  'nvim-lua/plenary.nvim',
  'nvim-lua/popup.nvim',
  'MunifTanjim/nui.nvim',
  'vim-jp/vimdoc-ja',
  -- colorscheme
  'EdenEast/nightfox.nvim',
  {
    'sainnhe/sonokai',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.sonokai_transparent_background = 1
      vim.cmd[[colorscheme sonokai]]
    end
  },
  -- ui
  'rcarriga/nvim-notify',
  'goolord/alpha-nvim',
  'folke/which-key.nvim',
  -- {
  --   'folke/noice.nvim',
  --   dependencies = {
  --     'rcarriga/nvim-notify',
  --     'MunifTanjim/nui.nvim'
  --   }
  -- },
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
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'onsails/lspkind-nvim',
    }
  },
  -- snippet

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
  { 'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    lazy  = true,
    keys = {
      { '<Leader>e', '<Cmd>Neotree<CR>', desc = 'Neotree' }
    }
  },

  -- terminal
  'akinsho/toggleterm.nvim',

  -- git support
  'lewis6991/gitsigns.nvim',
  'dinhhuy258/git.nvim',

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

  -- repl
  'hkupty/iron.nvim',
})
