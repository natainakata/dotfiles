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
lazy.setup(
  {
    -- runtime
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    'MunifTanjim/nui.nvim',
    -- 'vim-jp/vimdoc-ja',
    { 'folke/neodev.nvim', config = function() require('neodev').setup() end },
    -- colorscheme
    {
      'echasnovski/mini.nvim',
      lazy = false,
      config = function()
        require('mini.basics').setup({})
        vim.cmd[[colorscheme base16dracula]]
      end,
      priority = 1000,
    },
    { 'EdenEast/nightfox.nvim', config = function() require('plugins/nightfox') end },
    -- ui
    { 'rcarriga/nvim-notify', config = function() require('notify').setup() end },
    { 'folke/noice.nvim', config = function() require('plugins.noice') end },
    { 'goolord/alpha-nvim', config = function() require('plugins/alpha') end },
    {
      'folke/which-key.nvim',
      config = function()
        require('which-key').setup{
          window = {
            border = "double",
          }
        }
      end,
    },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require('plugins/lualine')
      end
    },
    {
      'akinsho/nvim-bufferline.lua',
      dependencies = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require('plugins/bufferline')
      end
    },

    -- language server
    {
      'williamboman/mason.nvim',
      dependencies = {
        'neovim/nvim-lspconfig',
        'williamboman/mason-lspconfig.nvim',
        'folke/trouble.nvim',
        'glepnir/lspsaga.nvim',
      },
      config = function()
        require('plugins/lsp')
      end
    },
    {
      'glepnir/lspsaga.nvim',
      config = function()
        require('lspsaga').setup()
        vim.keymap.set('n', '<Leader>lj', '<Cmd>Lspsaga diagnostic_jump_next<CR>')
        vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>')
        vim.keymap.set('n', '<Leader>lf', '<Cmd>Lspsaga lsp_finder<CR>')
        vim.keymap.set('n', '<Leader>lp', '<Cmd>Lspsaga preview_definition<CR>')
        vim.keymap.set('n', '<F2>', '<Cmd>Lspsaga rename<CR>')
      end,
    },

    -- outline
    {
      'stevearc/aerial.nvim',
      config = function()
        require('aerial').setup({
          on_attach = function(bufnr)
            vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr, silent = true})
            vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr, silent = true})
          end
        })
        vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
      end
    },

    -- compilation
    { 'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'onsails/lspkind-nvim' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-cmdline' },
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' }
      },
      config = function()
        require('plugins/cmp')
      end
    },

    -- syntax highlight
    { 'nvim-treesitter/nvim-treesitter',
      lazy = true,
      event = 'BufEnter',
      build = function()
        require('nvim-treesitter.install').update({ with_sync = true })
      end,
      dependencies = {
        'yioneko/nvim-yati',
        'romgrk/nvim-treesitter-context',
        'p00f/nvim-ts-rainbow',
        'nvim-treesitter/nvim-treesitter-textobjects',
      },
      config = function()
        require('plugins/treesitter')
      end
    },
    -- finder
    {
      'nvim-telescope/telescope.nvim',
      dependencies = {
        'nvim-telescope/telescope-file-browser.nvim',
        'tami5/sqlite.lua' ,
        'nvim-telescope/telescope-frecency.nvim',
        'nvim-telescope/telescope-symbols.nvim',
        'kyazdani42/nvim-web-devicons',
      },
      config = function()
        require('plugins/telescope')
      end,
    },

    -- explorer
    { 'nvim-neo-tree/neo-tree.nvim',
      branch = 'v2.x',
      config = function()
        require('plugins/neotree')
      end
    },

    -- terminal
    { 'akinsho/toggleterm.nvim', config = function() require('plugins/toggleterm') end },

    -- git support
    { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end },
    {
      'dinhhuy258/git.nvim',
      config = function()
        require('git').setup({
          keymaps = {
            -- Open blame window
            blame = '<Leader>gb',
            -- Open file/folder in git repository
            browse = '<Leader>go',
          }
        })
      end,
    },
    -- register
    'tversteeg/registers.nvim',

    -- auto pairs
    'cohama/lexima.vim',

    -- comment toggle
    'tpope/vim-commentary',

    -- easymotion
    { 'phaazon/hop.nvim',
      config = function()
        require('hop').setup()
      end,
      keys = {
        { '<Leader>h', ':<C-u>HopWord<CR>', silent = true },
        { '<Leader>H', ':<C-u>HopPattern<CR>', silent = true},
        { '<Leader>L', ':<C-u>HopLineStart<CR>', silent = true}
      }
    },

    -- surrounds
    { 'machakann/vim-sandwich', },

    -- colorizer
    { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end, },

    -- editorconfig
    'sgur/vim-editorconfig',

    -- scrollbjr
    'petertriho/nvim-scrollbar',

    -- zenscript
    {
      'DaeZak/crafttweaker-vim-highlighting',
      ft = 'crafttweaker',
    },

    -- highlight search
    { 'kevinhwang91/nvim-hlslens', config = function() require('hlslens').setup() end, },

    -- highlight yank
    'machakann/vim-highlightedyank',

    -- execute
    'thinca/vim-quickrun',

    -- markdown
    { "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end, },

    -- repl
    'hkupty/iron.nvim',

    -- dial
    {
      'monaqa/dial.nvim',
      lazy = true,
      keys = {
        { '+', '<Plug>(dial-increment)' },
        { '-', '<Plug>(dial-decrement)' },
      },
      config = function()
        local augend = require("dial.augend")
        require("dial.config").augends:register_group{
          -- augends used when group with name `mygroup` is specified
          default = {
            augend.integer.alias.decimal,
            augend.integer.alias.hex,
            augend.constant.alias.bool,
            augend.date.alias["%Y/%m/%d"],
          },
        }
      end
    }
  }
)

vim.keymap.set('n', '<Leader>lz', '<Cmd>Lazy log<CR>', { silent = true })
