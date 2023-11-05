local utils = require("rc.utils")
local helper = require("rc.utils.lsp")

local spec = {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      cmd = { "Mason", "MasonInstall", "MasonUnInstall", "MasonUnInstallAll" },
      opts = {
        ui = {
          check_outdated_packages_on_open = false,
          border = "single",
        },
      },
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "vimls",
        "powershell_es",
        "bashls",
        "denols",
        "pyright",
        "tsserver",
        "kotlin_language_server",
      },
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      { "folke/trouble.nvim",  dependencies = "nvim-web-devicons" },
      { "SmiteshP/nvim-navic", opts = { lsp = { auto_attach = true }, highlight = true } },
      { "folke/neodev.nvim",   opts = { experimental = { pathStrict = true } } },
      "hrsh7th/cmp-nvim-lsp",
      "nvimtools/none-ls.nvim",
    },
    init = function()
      helper.on_attach(function(client, bufnr)
        require("rc.init.plugins.lsp.keymaps").on_attach(client, bufnr)
      end)
    end,
    opts = require("rc.init.plugins.lsp.opts"),
    config = function(_, opts)
      vim.lsp.set_log_level("debug")
      local lspconfig = require("lspconfig")
      local settings = require("rc.init.plugins.lsp.settings")
      local function setup(client, server_opts)
        local default_opts = client.document_config.default_config
        local local_opts = utils.extend_tbl(opts, server_opts)
        local_opts.filetypes =
            utils.extend_tbl(local_opts.filetypes or default_opts.filetypes or {}, local_opts.extra_filetypes)
        local_opts.extra_filetypes = nil
        client.setup(local_opts)
      end
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({})
        end,
        ["lua_ls"] = function()
          setup(lspconfig["lua_ls"], settings.lua_ls)
        end,
        ["denols"] = function()
          setup(lspconfig["denols"], settings.denols)
        end,
        ["groovyls"] = function()
          setup(lspconfig["groovyls"], settings.groovyls)
        end,
        ["powershell_es"] = function()
          setup(lspconfig["powershell_es"], settings.powershell_es)
        end,
        ["kotlin_language_server"] = function()
          setup(lspconfig["kotlin_language_server"], settings.kotlin_language_server)
        end,
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua.with({
            filetypes = { "lua" },
          }),
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            utils.autocmd("lsp_formatting", "BufWritePre", nil, function()
              vim.lsp.buf.format()
            end, { buffer = bufnr })
          end
        end,
      })
    end,
  },
}

return spec
