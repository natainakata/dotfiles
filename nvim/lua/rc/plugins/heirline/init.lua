-- @type LazySpec[]
local spec = {
  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    enabled = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.opt.showmode = false
      vim.opt.laststatus = 3
      local heirline = require("heirline")
      -- require("rc.plugins.heirline.palette").init()
      heirline.setup({
        statusline = require("rc.plugins.heirline.status").statusline,
        winbar = require("rc.plugins.heirline.winbar").winbar,
        tabline = require("rc.plugins.heirline.tabbar").tabline,
        opts = {
          colors = heirline.load_colors(require("catppuccin.palettes").get_palette("frappe")),
          disable_winbar_cb = function(args)
            return require("heirline.conditions").buffer_matches({
              buftype = { "nofile", "prompt", "help", "quickfix" },
              filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
            }, args.buf)
          end,
        },
      })
      require("rc.utils").nmap("<Leader>b", function()
        local tabline = require("heirline").tabline
        local buflist = tabline._buflist[1]
        buflist._picker_labels = {}
        buflist._show_picker = true
        vim.cmd.redrawtabline()
        local char = vim.fn.getcharstr()
        local bufnr = buflist._picker_labels[char]
        if bufnr then
          vim.api.nvim_win_set_buf(0, bufnr)
        end
        buflist._show_picker = false
        vim.cmd.redrawtabline()
      end)
    end,
  },
}

return spec
