return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    keys = {
      {
        "<C-f>",
        function()
          require("telescope.builtin").find_files({
            no_ignore = false,
            hidden = false,
          })
        end,
        desc = "Find File",
      },
      {
        "<Leader><C-f>",
        function()
          require("telescope.builtin").find_files({
            no_ignore = true,
            hidden = true,
          })
        end,
        desc = "Find File (ALL)",
      },
      {
        "<Leader>/",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "live grep",
      },
      {
        "<Leader>b",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Buffer List",
      },
      {
        "<Leader>?",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Neovim Documents",
      },
      {
        "<Leader>r",
        function()
          require("telescope.builtin").oldfiles()
        end,
        desc = "Recent Files",
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.load_extension("file_browser")

      telescope.setup({
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
              ["q"] = actions.close,
            },
          },
          prompt_prefix = "  ",
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
      })
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    config = function()
      local telescope = require("telescope")
      local extensions = {
        file_browser = {
          theme = "cursor",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = false,
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
        "<Leader>f",
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
}
