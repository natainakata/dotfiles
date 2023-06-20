import type { Plug } from "https://deno.land/x/dvpm@1.0.0/mod.ts";

export const treesitter: Plug[] = [
  {
    url: "nvim-treesitter/nvim-treesitter",
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require("nvim-treesitter.configs").setup(_A.param)`,
        {
          param: {
            sync_install: false,
            ensure_installed: [
              "bash",
              "markdown",
              "markdown_inline",
              "make",
              "cmake",
              "toml",
              "yaml",
              "json",
              "vim",
              "lua",
              "typescript",
              "python",
              "scheme",
              "clojure",
              "java",
              "kotlin",
            ],
            highlight: {
              enable: true,
              additional_vim_regex_highlighting: false,
            },
          },
        },
      );
    },
  },
  {
    url: "yioneko/nvim-yati",
    dependencies: [{ url: "nvim-treesitter/nvim-treesitter" }],
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require("nvim-treesitter.configs").setup(_A.param)`,
        {
          param: {
            yati: {
              enable: true,
              default_lazy: true,
              default_fallback: "auto",
            },
            indent: {
              enable: false,
            },
          },
        },
      );
    },
  },
  {
    url: "nvim-treesitter/nvim-treesitter-context",
    dependencies: [{ url: "nvim-treesitter/nvim-treesitter" }],
    after: async ({ denops }) => {
      await denops.cmd(`lua require("treesitter-context").setup()`);
    },
  },
  {
    url: "HiPhish/nvim-ts-rainbow2",
    dependencies: [{ url: "nvim-treesitter/nvim-treesitter" }],
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require("nvim-treesitter.configs").setup(_A.param)`,
        {
          param: {
            rainbow: {
              enable: true,
              query: "rainbow-parens",
            },
          },
        },
      );
    },
  },
  //{
  //  url: "nvim-treesitter/nvim-treesitter-textobject",
  //  dependencies: [{ url: "nvim-treesitter/nvim-treesitter" }],
  //  after: async ({ denops }) => {
  //    await denops.call(
  //      `luaeval`,
  //      `require("nvim-treesitter.configs").setup(_A.param)`,
  //      {
  //        param: {
  //          textobjects: {
  //            select: {
  //              enable: true,
  //              lookahed: true
  //            },
  //          },
  //        },
  //      },
  //    );
  //  },
  //},
];
