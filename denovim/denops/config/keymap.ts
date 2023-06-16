import * as mapping from "https://deno.land/x/denops_std@v5.0.0/mapping/mod.ts";
import type { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";
import { batch } from "https://deno.land/x/denops_std@v5.0.0/batch/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.0/variable/mod.ts";

export async function setKeymapPre(denops: Denops) {
  await batch(denops, async (denops: Denops) => {
    await globals.set(denops, "mapleader", " ");
    await globals.set(denops, "maplocalleader", " ");
    const normalOpts: mapping.MapOptions = {
      mode: "n",
      silent: true,
      noremap: true,
    };

    await mapping.map(denops, "j", "gj", {
      mode: ["n", "x"],
    });
    await mapping.map(denops, "k", "gk", {
      mode: ["n", "x"],
    });

    await mapping.map(denops, "U", "<C-r>", {
      mode: "n",
    });
    await mapping.map(denops, "jj", "<Esc>", {
      mode: "i",
    });
    await mapping.map(denops, "<Esc><Esc>", "<Cmd>nohlsearch<CR>", normalOpts);
    await mapping.map(denops, "x", '"_x', normalOpts);
    await mapping.map(denops, "<S-h>", "<Cmd>bprevious<CR>", normalOpts);
    await mapping.map(denops, "<Leader>q", "<Cmd>qa<CR>", normalOpts);

    await mapping.map(denops, "<S-h>", "<Cmd>bprevious<CR>", normalOpts);
    await mapping.map(denops, "<S-l>", "<Cmd>bnext<CR>", normalOpts);

    await mapping.map(denops, "gs", "<Cmd>split<CR><C-w>w", normalOpts);
    await mapping.map(denops, "gv", "<Cmd>split<CR><C-w>w", normalOpts);

    const wincmdOpts: mapping.MapOptions = {
      mode: "n",
      silent: true,
    };
    await mapping.map(denops, "<C-h>", "<Cmd>wincmd h<CR>", wincmdOpts);
    await mapping.map(denops, "<C-j>", "<Cmd>wincmd j<CR>", wincmdOpts);
    await mapping.map(denops, "<C-k>", "<Cmd>wincmd k<CR>", wincmdOpts);
    await mapping.map(denops, "<C-l>", "<Cmd>wincmd l<CR>", wincmdOpts);

    await mapping.map(denops, "<C-Up>", "<Cmd> resize +2<CR>", wincmdOpts);
    await mapping.map(denops, "<C-Down>", "<Cmd> resize -2<CR>", wincmdOpts);
    await mapping.map(
      denops,
      "<C-Left>",
      "<Cmd>vertical resize -2<CR>",
      wincmdOpts,
    );
    await mapping.map(
      denops,
      "<C-Right>",
      "<Cmd>vertical resize +2<CR>",
      wincmdOpts,
    );

    await mapping.map(denops, "Z", ":set foldmethod=indent<CR>", normalOpts);
    const termOpts: mapping.MapOptions = {
      mode: "t",
      silent: true,
      noremap: true,
    };
    await mapping.map(denops, "<Leader>t", "<Cmd>terminal<CR>", normalOpts);
    await mapping.map(
      denops,
      "<Leader>T",
      "<Cmd>belowright new<CR><Cmd>terminal<CR>",
      normalOpts,
    );
    await mapping.map(denops, "JJ", "<C-\\><C-n>", termOpts);
    await mapping.map(denops, "<Esc><Esc>", "<C-\\><C-n>", termOpts);
  });
}

export async function setKeymapPost(denops: Denops) {
  await batch(denops, async (denops: Denops) => {
    await mapping.map(
      denops,
      "<Leader>D",
      `<Cmd> call denops#request("${denops.name}", "bufferDeleteSafety", [])`,
      { mode: "n" },
    );
  });
}
