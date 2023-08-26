local utils = require("rc.utils")

local spec = {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "folke/trouble.nvim", dependencies = "nvim-web-devicons" },
      -- {
      --   "j-hui/fidget.nvim",
      --   tag = "legacy",
      --   config = true,
      -- },
      { "SmiteshP/nvim-navic", opts = { lsp = { auto_attach = true }, highlight = true } },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      "mhartington/formatter.nvim",
      "mfussenegger/nvim-lint",
    },
    init = function()
      -- vim.lsp.set_log_level(vim.lsp.log_levels.DEBUG)
      utils.lsp.on_attach(function(client, bufnr)
        require("rc.plugins.lsp.keymaps").on_attach(client, bufnr)
      end)
    end,
    opts = require("rc.plugins.lsp.opts"),
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      -- lspconfig.configs.racketls = require("rc.plugins.lsp.custom.racketls")
      -- lspconfig.configs.goshls = require("rc.plugins.lsp.custom.goshls")
      local function setup(client, server_opts)
        local default_opts = client.document_config.default_config
        local local_opts = utils.extend_tbl(opts, server_opts)

        local_opts.filetypes =
          utils.extend_tbl(local_opts.filetypes or default_opts.filetypes or {}, local_opts.extra_filetypes)
        local_opts.extra_filetypes = nil
        client.setup(local_opts)
      end

      local servers = require("rc.plugins.lsp.settings.init")

      for k, v in pairs(servers) do
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
    "mhartington/formatter.nvim",
    keys = { "<Leader>F", "<Cmd>Format<CR>" },
    config = function()
      require("formatter").setup({
        filetype = {
          lua = {
            require("formatter.filetypes.lua").stylua,
          },
          ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace,
          },
        },
      })
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = utils.augroup("FormatAutogroup"),
        command = "FormatWrite",
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      by_ft = {
        lua = {
          "luacheck",
        },
      },
    },
    config = function(_, opts)
      require("lint").linters_by_ft = opts.by_ft
      local luacheck = require("lint").linters.luacheck
      luacheck.args = {
        "--formatter",
        "plain",
        "--codes",
        "--ranges",
        "--config",
        "~/.dotfiles/.luacheckrc",
        "-",
      }
      vim.api.nvim_create_autocmd({ "TextChanged", "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}

return spec
