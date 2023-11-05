local utils = require("rc.utils")
local helper = require("rc.utils.lsp")

local spec = {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "williamboman/mason.nvim",
        dependencies = "williamboman/mason-lspconfig.nvim",
        keys = { { "<leader>lm", "<cmd>Mason<CR>", desc = "Mason" } },
        opts = {
          ensure_installed = {
            "luacheck",
            "shellcheck",
            "shfmt",
            "flake8",
            "prettier",
            "lua-language-server",
            "vim-language-server",
            "groovy-language-server",
          },
          ui = {
            check_outdated_packages_on_open = false,
            border = "single",
          },
        },
        config = function(_, opts)
          require("mason").setup(opts)
          require("mason-lspconfig").setup()
        end,
      },
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
          setup(lspconfig["powershell_es"], settings.groovyls)
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
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.completion.spell,
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
