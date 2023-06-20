import type { Plug } from "https://deno.land/x/dvpm@1.0.0/mod.ts";

export const coding: Plug[] = [
  {
    url: "kylechui/nvim-surround",
    after: async ({ denops }) => {
      await denops.cmd(`lua require("nvim-surround").setup()`);
    },
  },
  {
    url: "cohama/lexima.vim", // after: async ({ denops }) => {
  },
  {
    url: "thinca/vim-partedit",
  },
  {
    url: "numToStr/Comment.nvim",
    after: async ({ denops }) => {
      await denops.cmd(`lua require("Comment").setup()`);
    },
  },
];
