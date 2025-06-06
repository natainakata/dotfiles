local spec = {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VimEnter",
    version = false,
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- "RRethy/nvim-treesitter-endwise",
      "andymass/vim-matchup",
      "monaqa/tree-sitter-unifieddiff",
      "nvim-treesitter/playground",
    },
    opts = {
      highlight = {
        enable = true,
        disable = {},
      },
      indent = {
        enable = false,
        disable = { "scheme", "clojure", "python" },
      },
      ensure_installed = {
        -- shell
        "bash",
        -- documents
        "markdown",
        "markdown_inline",
        -- build tool
        "make",
        "cmake",
        -- conf file
        "toml",
        "yaml",
        "json",
        -- vim conf
        "vim",
        "lua",
        -- web
        "javascript",
        "typescript",
        "css",
        "html",
        -- script
        "python",
        -- lisp
        "scheme",
        "clojure",
        -- java
        "java",
        "kotlin",
        "groovy",
        -- c
        "c",
        "cpp",
      },
      autotag = {
        enable = true,
      },
      --[[ endwise = {
        enable = true,
      }, ]]
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
          },

          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
          },
          include_surrounding_whitespace = true,
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      },
      matchup = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      vim.treesitter.language.register("typescript", "typescriptreact")
      vim.treesitter.language.register("bash", "zsh")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = true,
  },
}

return spec
