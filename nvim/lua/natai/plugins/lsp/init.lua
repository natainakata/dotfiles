local utils = require("natai.utils")

local spec = {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/trouble.nvim",
      -- {
      --   "j-hui/fidget.nvim",
      --   tag = "legacy",
      --   config = true,
      -- },
      { "SmiteshP/nvim-navic", opts = { lsp = { auto_attach = true }, highlight = true } },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
    },
    init = function()
      utils.lsp.on_attach(function(client, bufnr)
        require("natai.plugins.lsp.keymaps").on_attach(client, bufnr)
        require("natai.plugins.lsp.format").on_attach(client, bufnr)
      end)
    end,
    opts = function()
      local o = {}
      o.opts = {}
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      }
      -- utils.ensure("cmp_nvim_lsp", function(m)
      --   capabilities = m.default_capabilities(capabilities)
      -- end)
      o.opts.capabilities = capabilities
      local function format_diagnostics(diag)
        if diag.code then
          return string.format("[%s](%s): %s", diag.source, diag.code, diag.message)
        else
          return string.format("[%s]: %s", diag.source, diag.message)
        end
      end
      local diagnosis_config = {
        format = format_diagnostics,
        header = {},
        scope = "cursor",
      }
      vim.lsp.set_log_level(vim.lsp.log_levels.DEBUG)
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        update_in_insert = false,
        float = diagnosis_config,
        virtual_text = diagnosis_config,
      })
      for name, icon in pairs(require("natai.utils.icons").diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      o.opts.diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = diagnosis_config,
        float = diagnosis_config,
        severity_sort = true,
      }
      o.opts.update_in_insert = true
      o.opts.underline = true
      o.opts.severity_sort = true
      o.opts.float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      }
      return o
    end,
    config = function(_, opts)
      opts = opts.opts
      local lspconfig = require("lspconfig")
      -- lspconfig.configs.racketls = require("natai.plugins.lsp.custom.racketls")
      -- lspconfig.configs.goshls = require("natai.plugins.lsp.custom.goshls")
      local function setup(client, server_opts)
        local default_opts = client.document_config.default_config
        local local_opts = utils.extend_tbl(opts, server_opts)

        local_opts.filetypes =
          utils.extend_tbl(local_opts.filetypes or default_opts.filetypes or {}, local_opts.extra_filetypes)
        local_opts.extra_filetypes = nil
        client.setup(local_opts)
      end

      local servers = require("natai.plugins.lsp.settings.init")

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
        "stylua",
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
    "mfussenegger/nvim-dap",
    event = "LspAttach",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        opts = {
          mappings = {
            -- Use a table to apply multiple mappings
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
            toggle = "t",
          },
          expand_lines = true,
          layouts = {
            {
              elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.25 },
                "breakpoints",
                "stacks",
                "watches",
              },
              size = 40, -- 40 columns
              position = "left",
            },
            {
              elements = {
                "repl",
              },
              size = 0.25, -- 25% of total lines
              position = "bottom",
            },
          },
          controls = {
            -- Requires Neovim nightly (or 0.8 when released)
            enabled = true,
            -- Display controls in this element
            element = "repl",
          },
          floating = {
            max_height = nil, -- These can be integers or a float between 0 and 1.
            max_width = nil, -- Floats will be treated as percentage of your screen.
            border = "single", -- Border style. Can be "single", "double" or "rounded"
            mappings = {
              close = { "q", "<Esc>" },
            },
          },
          windows = { indent = 1 },
          render = {
            max_type_length = nil, -- Can be integer or nil.
            max_value_lines = 100, -- Can be integer or nil.
          },
        },
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "williamboman/mason.nvim",
        config = function()
          require("mason-nvim-dap").setup({
            ensure_installed = { "python" },
          })
        end,
      },
    },
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<F12>",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint()
        end,
        desc = "Set Breakpoint",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.open()
        end,
        desc = "Open REPL",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run Last",
      },
      {
        "<leader>dd",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle UI",
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "LspAttach" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")

      return {
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.flake8,
        },
      }
    end,
  },
}

if vim.g.vscode then
  return {}
else
  return spec
end
