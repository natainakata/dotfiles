local spec = {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        opts = require("rc.init.plugins.dap.ui").opts,
        config = require("rc.init.plugins.dap.ui").setup,
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "williamboman/mason.nvim",
        opts = {
          ensure_installed = { "python" },
          handlers = {
            python = function(source_name)
              local dap = require("dap")
              dap.adapters.python = {
                type = "executable",
                command = "/usr/bin/python",
                args = {
                  "-m",
                  "debugpy.adapter",
                },
              }
              require("mason-nvim-dap").default_setup(source_name)
            end,
          },
        },
        config = function(_, opts)
          require("mason-nvim-dap").setup(opts)
        end,
      },
    },
    keys = require("rc.init.plugins.dap.keymaps").keys,
    config = function()
      for name, icon in pairs(require("rc.utils.icons").dap) do
        name = name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
    end,
  },
}

return spec
