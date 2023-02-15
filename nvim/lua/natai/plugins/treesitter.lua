return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = "BufEnter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    dependencies = {
      "yioneko/nvim-yati",
      "romgrk/nvim-treesitter-context",
      "p00f/nvim-ts-rainbow",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      highlight = {
        enable = true,
        disable = {},
      },
      indent = {
        enable = true,
        disable = {},
      },
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "cmake",
        "css",
        "html",
        "java",
        "javascript",
        "go",
        "json",
        "kotlin",
        "lua",
        "make",
        "pug",
        "php",
        "markdown",
        "markdown_inline",
        "python",
        "rust",
        "scss",
        "toml",
        "typescript",
        "vim",
        "vue",
        "yaml",
      },
      autotag = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
      require("nvim-treesitter.install").compilers = { "zig" }
    end,
  },
}
