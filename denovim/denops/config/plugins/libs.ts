import type { Plug } from "https://deno.land/x/dvpm@1.0.0/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.0/mapping/mod.ts";

export const libs: Plug[] = [
  { url: "vim-denops/denops.vim" },
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
