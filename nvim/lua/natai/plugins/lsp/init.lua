local utils = require("natai.util")
local function format_diagnostics(diag)
  if diag.code then
    return string.format("[%s](%s): %s", diag.source, diag.code, diag.message)
  else
    return string.format("[%s]: %s", diag.source, diag.message)
  end
end

-- local lsp_server_list = {}
-- local lsp_config_table = {}
--
local diagnosis_config = {
  format = format_diagnostics,
  header = {},
  scope = "cursor",
}

local function setup_lsp_global()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    update_in_insert = false,
    float = diagnosis_config,
    virtual_text = diagnosis_config,
  })
  for name, icon in pairs(require("natai.icons").diagnostics) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
  end

  -- vim.api.nvim_create_autocmd("LspAttach", {
  --   once = true,
  --   callback = function()
  --     vim.lsp.handlers["textDocument/hover"] = function(_, results, ctx, config)
  --       local client = vim.lsp.get_client_by_id(ctx.client_id)
  --       vim.lsp.handlers.hover(
  --         _,
  --         results,
  --         ctx,
  --         vim.tbl_deep_extend("force", config or {}, {
  --           border = "single",
  --           title = " " .. client.name .. " ",
  --         })
  --       )
  --     end
  --   end,
  -- })
end

local function register_lsp_servers(servers)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }
  utils.ensure("cmp_nvim_lsp", function(m)
    capabilities = m.default_capabilities(capabilities)
  end)
  local function register(name, config)
    config.capabilities = vim.deepcopy(capabilities)
    config.on_attach = utils.on_attach(function(client, buffer)
      require("natai.plugins.lsp.keymaps").on_attach(client, buffer)
      require("natai.plugins.lsp.format").on_attach(client, buffer)
      if client.server_capabilities.documentSymbolProvider then
        utils.ensure("nvim-navic", function(m)
          m.attach(client, buffer)
        end)
      end
    end)
    utils.ensure("lspconfig", function(m)
      m[name].setup(config)
    end)
  end
  for k, v in pairs(servers) do
    register(k, v)
  end
end

local spec = {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/trouble.nvim",
      "SmiteshP/nvim-navic",
      -- {
      --   "tamago324/nlsp-settings.nvim",
      --   opts = {
      --     config_home = vim.fn.stdpath("config") .. "/nlsp-settings",
      --     local_settings_dir = ".nlsp-settings",
      --     local_settings_root_markers_fallback = { ".git" },
      --     append_default_schemas = true,
      --     loader = "json",
      --   },
      -- },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = diagnosis_config,
        float = diagnosis_config,
        severity_sort = true,
      },
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        powershell_es = {
          mason = false,
          settings = {
            powershell = {
              codeFormatting = {
                preset = "OTBS",
                newLineAfterOpenBrace = false,
                newLineAfterCloseBrace = true,
              },
            },
          },
          on_attach = require("natai.util").on_attach(function(client, buffer)
            client.server_capabilities.semanticTokensProvider = nil
          end),
        },
      },
    },
    config = function(_, opts)
      setup_lsp_global()
      register_lsp_servers(opts.servers)
      -- local mappings = require("mason-lspconfig.mappings.server")
      -- if not mappings.lspconfig_to_package.lua then
      --   mappings.lspconfig_to_package.lua_ls = "lua-language-server"
      --   mappings.package_to_lspconfig["lua-language-server"] = "lua_ls"
      -- end
      --
      -- local mlsp = require("mason-lspconfig")
      -- local available = mlsp.get_available_servers()
      -- local ensure_installed = {}
      -- for server, server_opts in pairs(servers) do
      --   if server_opts then
      --     server_opts = server_opts == true and {} or server_opts
      --     -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
      --     if server_opts.mason == false or not vim.tbl_contains(available, server) then
      --       setup(server)
      --     else
      --       ensure_installed[#ensure_installed + 1] = server
      --     end
      --   end
      -- end
      -- require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
      -- require("mason-lspconfig").setup_handlers({ setup })
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>lm", "<cmd>Mason<CR>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "lua-language-server",
        "bash-language-server",
        "vim-language-server",
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "prettier",
      },
    },
    config = function(plugin, opts)
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
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          require("dapui").setup()
        end,
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
          require("mason-nvim-dap").setup()
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

return spec
