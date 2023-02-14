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
}
