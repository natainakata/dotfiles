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
  spec = {
    -- runtime
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    'MunifTanjim/nui.nvim',
    -- 'vim-jp/vimdoc-ja',
    -- colorscheme
    {
      'echasnovski/mini.nvim',
      config = function()
        require('mini.basics').setup({})
        vim.cmd[[colorscheme base16sonokai]]
      end,
      priority = 1000,
    },
    { 'EdenEast/nightfox.nvim', config = function() require('natainakata.plugins/nightfox') end },
    -- ui
    {
      'folke/noice.nvim',
      dependencies = {
        { 'rcarriga/nvim-notify', config = function()
          require('notify').setup()
        end },
      },
      config = function()
        require('natainakata.plugins.noice')
      end
    },
    { 'goolord/alpha-nvim', config = function() require('natainakata.plugins.alpha') end },
    {
      'folke/which-key.nvim',
      config = function()
        require('which-key').setup{
          window = {
            border = "none",
          }
        }
      end,
    },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require('natainakata.plugins.lualine')
      end
    },
    {
      'akinsho/nvim-bufferline.lua',
      dependencies = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require('natainakata.plugins.bufferline')
      end
    },
    { 'petertriho/nvim-scrollbar', config = function() require('scrollbar').setup() end },
    -- language server
    {
      'williamboman/mason.nvim',
      dependencies = {
        'neovim/nvim-lspconfig',
        'williamboman/mason-lspconfig.nvim',
        'folke/trouble.nvim',
        'glepnir/lspsaga.nvim',
        {
          'folke/neodev.nvim',
          config = function()
            require('neodev').setup({
              library = { plugins = { 'nvim-dap-ui' }, types = true},
            })
          end
        },
        {
          'mfussenegger/nvim-dap',
          dependencies = {
            { 'rcarriga/nvim-dap-ui', config = function() require('dapui').setup() end },
            { 'jay-babu/mason-nvim-dap.nvim', config = function() require('mason-nvim-dap').setup() end}
          },
          config = function()
            require('natainakata.plugins.dap')
          end
        },
      },
      config = function()
        require('natainakata.plugins.lsp')
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
      'simrat39/symbols-outline.nvim',
      lazy = true,
      keys = {
        { '<Leader>a', '<cmd>SymbolsOutline<CR>'}
      },
      config = function ()
        require('symbols-outline').setup()
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
        require('natainakata.plugins.cmp')
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
        require('natainakata.plugins.treesitter')
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
        require('natainakata.plugins.telescope')
      end,
    },

    -- explorer
    { 'nvim-neo-tree/neo-tree.nvim',
      branch = 'v2.x',
      config = function()
        require('natainakata.plugins.neotree')
      end
    },

    -- terminal
    { 'akinsho/toggleterm.nvim', config = function() require('natainakata.plugins/toggleterm') end },

    -- git support
    {
      'lewis6991/gitsigns.nvim',
      dependencies = {
        'petertriho/nvim-scrollbar',
      },
      config = function()
        require('gitsigns').setup()
        require("scrollbar.handlers.gitsigns").setup()
      end
    },
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
    {
      'windwp/nvim-autopairs',
      lazy = true,
      event = 'InsertEnter',
      config = function()
        require("nvim-autopairs").setup()
      end
    },

    -- comment toggle
    { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end },

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
    {
      'machakann/vim-sandwich',
      lazy = true,
      keys = {
        { 'sa', '<Plug>(sandwich-add)' },
        { 'sd', '<Plug>(sandwich-delete)' },
        { 'sdb', '<Plug>(sandwich-delete-auto)' },
        { 'sr', '<Plug>(sandwich-replace)' },
        { 'srb', '<Plug>(sandwich-replace-auto)' },
      }
    },

    -- colorizer
    { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end, },

    -- editorconfig
    'sgur/vim-editorconfig',

    -- scrollbjr

    -- zenscript
    {
      'DaeZak/crafttweaker-vim-highlighting',
      ft = 'crafttweaker',
    },

    -- highlight search
    {
      'kevinhwang91/nvim-hlslens',
      dependencies = {
        'petertriho/nvim-scrollbar'
      },
      config = function()
        require('scrollbar.handlers.search').setup()
      end,
    },

    -- highlight yank
    'machakann/vim-highlightedyank',

        -- markdown
    { "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end, },

    -- repl
    {
      'hkupty/iron.nvim',
      lazy = true,
      keys = {
        { '<Leader>Is', '<cmd>IronRepl<cr>'},
        { '<Leader>Ir', '<cmd>IronRestart<cr>'},
        { '<Leader>If', '<cmd>IronFocus<cr>'},
        { '<Leader>Ih', '<cmd>IronHide<cr>'}
      },
      config = function()
        require('natainakata.plugins.iron')
      end
    },

    -- dial
    {
      'monaqa/dial.nvim',
      lazy = true,
      keys = {
        { '+', '<Plug>(dial-increment)' },
        { '-', '<Plug>(dial-decrement)' },
      },
      config = function()
        require('natainakata.plugins.dial')
      end
    }
  },
  checker = { enabled = true },
})

vim.keymap.set('n', '<Leader>lz', '<Cmd>Lazy log<CR>', { silent = true })
