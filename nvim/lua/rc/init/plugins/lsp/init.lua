local utils = require("rc.utils")
local helper = require("rc.utils.lsp")

local function servers()
  return {
    lua_ls = require("rc.init.plugins.lsp.settings.lua"),
    denols = require("rc.init.plugins.lsp.settings.deno"),
    powershell_es = require("rc.init.plugins.lsp.settings.powershell"),
    pyright = {},
    tsserver = {},
    kotlin_language_server = require("rc.init.plugins.lsp.settings.kotlin"),
  }
end

local spec = {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "folke/trouble.nvim", dependencies = "nvim-web-devicons" },
      { "SmiteshP/nvim-navic", opts = { lsp = { auto_attach = true }, highlight = true } },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
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
      local function setup(client, server_opts)
        local default_opts = client.document_config.default_config
        local local_opts = utils.extend_tbl(opts, server_opts)

        local_opts.filetypes =
          utils.extend_tbl(local_opts.filetypes or default_opts.filetypes or {}, local_opts.extra_filetypes)
        local_opts.extra_filetypes = nil
        client.setup(local_opts)
      end

      for k, v in pairs(servers()) do
        setup(lspconfig[k], v)
      end
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
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
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
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
