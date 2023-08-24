local M = {}
M.keys = {
  {
    "<leader>x",
    function()
      require("dap").continue()
    end,
    desc = "DAP Continue",
  },
  {
    "<F5>",
    function()
      require("dap").continue()
    end,
    desc = "DAP Continue",
  },
  {
    "<F10>",
    function()
      require("dap").step_over()
    end,
    desc = "DAP Step Over",
  },
  {
    "<F11>",
    function()
      require("dap").step_into()
    end,
    desc = "DAP Step Into",
  },
  {
    "<F12>",
    function()
      require("dap").step_out()
    end,
    desc = "DAP Step Out",
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
      require("dap").repl.toggle()
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
    "<leader>dh",
    function()
      require("dap.ui.widgets").hover()
    end,
    desc = "Hover",
  },
  {
    "<leader>dp",
    function()
      require("dap.ui.widgets").preview()
    end,
    desc = "Preview",
  },
  {
    "<leader>df",
    function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.frames)
    end,
    desc = "Frames Centerd",
  },
  {
    "<leader>ds",
    function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.scopes)
    end,
    desc = "Scopes Centerd",
  },
  {
    "<leader>dd",
    function()
      require("dapui").toggle()
    end,
    desc = "Toggle UI",
  },
}

return M
