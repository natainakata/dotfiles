local utils = require("rc.utils")
local spec = {
  {
    "akinsho/toggleterm.nvim",
    enabled = not vim.g.vscode,
    keys = {
      { "<Leader>G", "<Cmd>exe v:count1 . 'lua _G.lazygit_toggle()'<CR>", desc = "lazygit" },
      { "<C-t>", [[<Cmd>exe v:count1 . "ToggleTerm"<CR>]], mode = "n", desc = "Terminal" },
      { "<C-t>", [[<Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>]], mode = "i", desc = "Terminal" },
    },
    config = function()
      local toggleterm = require("toggleterm")
      local terminal = require("toggleterm.terminal").Terminal
      toggleterm.setup({
        -- size can be a number or function which is passed the current terminal
        size = function(term)
          if term.direction == "horizontal" then
            return 10
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        on_open = function(term)
          utils.ensure("nvim-tree.api", function(m)
            local nvimtree_view = require("nvim-tree.view")
            if nvimtree_view.is_visible() and term.direction == "horizontal" then
              local nvimtree_width = vim.fn.winwidth(nvimtree_view.get_winnr())
              m.tree.toggle()
              nvimtree_view.View.width = nvimtree_width
              m.tree.toggle(false, true)
            end
          end)
        end,
        open_mapping = [[<c-\><c-\>]],
        shade_terminals = true,
        shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true, -- close the terminal window when the process exits
        shell = vim.o.shell, -- change the default shell
        -- This field is only relevant if direction is set to 'float'
        float_opts = {
          -- The border key is *almost* the same as 'nvim_open_win'
          -- see :h nvim_open_win for details on borders however
          -- the 'curved' border is a custom border type
          -- not natively supported but implemented in this plugin.
          border = "double",
          width = 160,
          height = 60,
          winblend = 0,
        },
      })

      vim.api.nvim_create_autocmd("TermEnter", {
        pattern = "term://*toggleterm#*",
        callback = function()
          vim.keymap.set("t", "<C-t>", [[<Cmd>exe v:count1 . "ToggleTerm"<CR>]], { silent = true })
        end,
      })
      local lazygit = terminal:new({
        cmd = "lazygit",
        hidden = true,
        count = 5,
        direction = "float",
        on_open = function(_)
          vim.cmd("startinsert!")
        end,
      })

      function _G.lazygit_toggle()
        lazygit:toggle()
      end
    end,
  },
}

return spec
