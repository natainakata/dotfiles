import type { Plug } from "https://deno.land/x/dvpm@1.0.0/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.0.0/autocmd/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v5.0.0/lambda/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";
import * as nvimFn from "https://deno.land/x/denops_std@v5.0.0/function/nvim/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.0/variable/variable.ts";

export const ui: Plug[] = [
  {
    url: "navarasu/onedark.nvim",
    after: async ({ denops }) => {
      await denops.cmd("colorscheme onedark");
    },
  },
];
