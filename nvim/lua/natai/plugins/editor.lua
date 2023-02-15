return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    keys = {
      { "<leader>e", "<Cmd>Neotree<CR>", desc = "Neotree" },
    },
    opts = {
      filesystem = {
        hijack_netrw_behavior = "open_default",
      },
    },
  },
  {
    "hkupty/iron.nvim",
    keys = {
      { "<Leader>Is", "<cmd>IronRepl<cr>", desc = "IronRepl" },
      { "<Leader>Ir", "<cmd>IronRestart<cr>", desc = "IronRestart" },
      { "<Leader>If", "<cmd>IronFocus<cr>", desc = "IronFocus" },
      { "<Leader>Ih", "<cmd>IronHide<cr>", desc = "IronHide" },
    },
    config = function()
      local iron = require("iron.core")
      local view = require("iron.view")
      iron.setup({
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { "zsh" },
            },
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = view.split("40%"),
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = {
          send_motion = "<space>sc",
          visual_send = "<space>sc",
          send_file = "<space>sf",
          send_line = "<space>sl",
          send_mark = "<space>sm",
          mark_motion = "<space>mc",
          mark_visual = "<space>mc",
          remove_mark = "<space>md",
          cr = "<space>s<cr>",
          interrupt = "<space>s<space>",
          exit = "<space>sq",
          clear = "<space>cl",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true,
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      })
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    lazy = true,
    cmd = "SymbolsOutline",
    keys = {
      { "<Leader>o", "<cmd>SymbolsOutline<CR>" },
    },
    config = true,
  },
  {
    "dinhhuy258/git.nvim",
    opts = {
      keymaps = {
        -- Open blame window
        blame = "<Leader>gb",
        -- Open file/folder in git repository
        browse = "<Leader>go",
      },
    },
  },
  {
    "phaazon/hop.nvim",
    config = true,
    keys = {
      { "<Leader>h", ":<C-u>HopWord<CR>", silent = true },
      { "<Leader>H", ":<C-u>HopPattern<CR>", silent = true },
      { "<Leader>L", ":<C-u>HopLineStart<CR>", silent = true },
    },
  },
}
