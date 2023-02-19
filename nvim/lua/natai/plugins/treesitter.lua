return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = "BufEnter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-endwise",
      "p00f/nvim-ts-rainbow",
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
      rainbow = {
        enable = true,
      },
      endwise = {
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
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = true,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    init = function()
      -- no need to load the plugin, since we only need its queries
      require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
    end,
  },
}
