local utils = require("natai.util")
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

local function setup_lsp_global()
  vim.lsp.set_log_level(vim.lsp.log_levels.DEBUG)
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    update_in_insert = false,
    float = diagnosis_config,
    virtual_text = diagnosis_config,
  })
  for name, icon in pairs(require("natai.icons").diagnostics) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
  end
end
local function definition_custom_server()
  utils.ensure("lspconfig.configs", function(m)
    m.racketls = require("natai.plugins.lsp.custom.racketls")
    -- m.goshls = require("natai.plugins.lsp.custom.goshls")
  end)
end

local function register_lsp_servers(opts)
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
    local server_opts = vim.tbl_deep_extend("force", {
      capabilities = vim.deepcopy(capabilities),
      on_attach = utils.on_attach(function(client, buffer)
        require("natai.plugins.lsp.keymaps").on_attach(client, buffer)
        require("natai.plugins.lsp.format").on_attach(client, buffer)
      end),
    }, config or {})
    if opts.setup[name] then
      if opts.setup[name](name, server_opts) then
        return
      elseif opts.setup["*"] then
        if opts.setup["*"](name, server_opts) then
          return
        end
      end
    end
    utils.ensure("lspconfig", function(m)
      m[name].setup(server_opts)
    end)
  end
  utils.ensure("mason-lspconfig", function(m)
    local available = m.get_available_servers()
    local ensure_installed = {}
    for server, server_opts in pairs(opts.servers) do
      if server_opts then
        server_opts = server_opts == true and {} or server_opts
        if server_opts.mason == false or not vim.tbl_contains(available, server) then
          register(server, server_opts)
        else
          ensure_installed[#ensure_installed + 1] = server
        end
      end
    end
    m.setup({ ensure_installed = ensure_installed })
    m.setup_handlers({ register })
  end)
end

local spec = {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/trouble.nvim",
      { "SmiteshP/nvim-navic", opts = { lsp = { auto_attach = true }, highlight = true } },
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
        bashls = {
          mason = false,
        },
        denols = {
          root_dir = utils.ensure("lspconfig.utils", function(m)
            m.root_pattern("deno.json")
          end),
          init_options = {
            lint = true,
            unstable = true,
            suggest = {
              imports = {
                hosts = {
                  ["https://deno.land"] = true,
                  ["https://cdn.nest.land"] = true,
                  ["https://crux.land"] = true,
                },
              },
            },
          },
        },
        kotlin_language_server = {
          root_dir = utils.ensure("lspconfig.utils", function(m)
            m.root_pattern("build.gradle.kts")
          end),
        },
        vimls = {},
        -- scheme_langserver = {
        --   mason = false,
        -- },
        -- goshls = {
        --   mason = false,
        -- },
        racketls = {
          mason = false,
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
      setup = {},
    },
    config = function(_, opts)
      setup_lsp_global()
      definition_custom_server()
      register_lsp_servers(opts)
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

if vim.g.vscode then
  return {}
else
  return spec
end
