local utils = require("rc.utils")
local helper = require("rc.utils.lsp")

local spec = {
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUnInstall", "MasonUnInstallAll" },
        opts = {
          ui = {
            check_outdated_packages_on_open = false,
            border = "single",
          },
        },
      },
      { "folke/trouble.nvim", dependencies = "nvim-web-devicons" },
      { "SmiteshP/nvim-navic", opts = { lsp = { auto_attach = true }, highlight = true } },
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "luvit-meta/library", words = { "vim%.uv" } },
          },
        },
      },
      {
        "neovim/nvim-lspconfig",
        opts = require("rc.init.plugins.lsp.opts"),
        config = function(_, opts)
          vim.lsp.config("*", opts)
        end,
      },
      "jay-babu/mason-null-ls.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    init = function()
      helper.on_attach(function(client, bufnr)
        require("rc.init.plugins.lsp.keymaps").on_attach(client, bufnr)
        utils.autocmd("LspFormatting", "BufWritePre", { "*.rs", "*.py", "*.ts" }, function()
          vim.lsp.buf.format({
            buffer = bufnr,
            filter = function(client)
              return client.name ~= "null-ls"
            end,
            async = false,
          })
        end)
      end)
    end,
    opts = {
      ensure_installed = {
        "lua_ls",
        "vimls",
        "bashls",
        "denols",
        "nil_ls",
      },
      automatic_installation = true,
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "nvimtools/none-ls.nvim",
        "williamboman/mason.nvim",
        "lukas-reineke/lsp-format.nvim",
        "nvim-lua/plenary.nvim",
      },
    },
    opts = {
      ensure_installed = {
        "prettierd",
        "stylua",
        "clang_format",
        "black",
        "nixpkgs-fmt",
      },
      handlers = {},
      automatic_installation = true,
    },
    config = function(_, opts)
      require("mason-null-ls").setup(opts)
      local null_ls = require("null-ls")
      local lsp_format = require("lsp-format")
      lsp_format.setup()
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.prettierd,
        },
        on_attach = function(client, bufnr)
          lsp_format.on_attach(client, bufnr)
        end,
      })
    end,
  },
}

return spec
