import type { Plug } from "https://deno.land/x/dvpm@1.0.0/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.0/mapping/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.0/helper/mod.ts";

export const libs: Plug[] = [
  { url: "vim-denops/denops.vim" },
  {
    url: "MunifTanjim/nui.nvim",
    enabled: async ({ denops }) => await fn.has(denops, "nvim"),
  },
  {
    url: "nvim-tree/nvim-web-devicons",
    enabled: async ({ denops }) => await fn.has(denops, "nvim"),
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require("nvim-web-devicons").setup(_A.param)`,
        {
          param: {
            default: true,
          },
        },
      );
    },
  },
  {
    url: "nvim-lua/plenary.nvim",
    enabled: async ({ denops }) => await fn.has(denops, "nvim"),
  },
  {
    url: "rcarriga/nvim-notify",
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require("notify").setup(_A.param)`,
        {
          param: {
            background_colour: "NormalFloat",
          },
        },
      );
      await execute(denops, `lua vim.notify = require("notify")`);
      await mapping.map(
        denops,
        "<leader>nu",
        `<Cmd>lua require("notify").dismiss()<CR>`,
        {
          mode: "n",
        },
      );
    },
  },
];
