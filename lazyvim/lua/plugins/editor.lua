return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-file-browser.nvim",
        config = function()
          local telescope = require("telescope")
          local extensions = {
            file_browser = {
              theme = "cursor",
              -- disables netrw and use telescope-file-browser in its place
              hijack_netrw = true,
              mappings = {
                -- your custom insert mode mappings
                ["i"] = {
                  ["<C-w>"] = function()
                    vim.cmd("normal vbd")
                  end,
                },
                ["n"] = {
                  -- your custom normal mode mappings
                  ["N"] = require("telescope").extensions.file_browser.actions.create,
                  ["h"] = require("telescope").extensions.file_browser.actions.goto_parent_dir,
                  ["/"] = function()
                    vim.cmd("startinsert")
                  end,
                },
              },
            },
          }
          telescope.load_extension("file_browser")
          telescope.setup({
            extensions = extensions,
          })
        end,
        keys = {
          {
            "<leader>F",
            function()
              require("telescope").extensions.file_browser.file_browser({
                path = vim.fn.getcwd(),
                cwd = vim.fn.getcwd(),
                respect_gitignore = false,
                hidden = true,
                grouped = true,
                previewer = false,
                initial_mode = "normal",
                layout_config = { height = 0.5 },
              })
            end,
            desc = "File Browser",
          },
        },
      },
      { "nvim-telescope/telescope-symbols.nvim" },
    },
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        mappings = {
          n = {
            ["q"] = require("telescope.actions").close,
          },
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_storategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.5,
            results_width = 0.6,
          },
          vertical = {
            mirror = false,
          },
          width = 0.7,
          height = 0.8,
          preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
        },
      },
    },
  },
  {
    "monaqa/dial.nvim",
    keys = {
      { "+", "<Plug>(dial-increment)", desc = "Increment" },
      { "-", "<Plug>(dial-decrement)", desc = "Decrement" },
    },
    config = function()
      local dial = require("dial.config")
      local augend = require("dial.augend")
      dial.augends:register_group({
        -- augends used when group with name `mygroup` is specified
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.constant.alias.bool,
          augend.date.alias["%Y/%m/%d"],
        },
      })
    end,
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
}
