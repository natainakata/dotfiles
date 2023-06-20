import type { Plug } from "https://deno.land/x/dvpm@1.0.0/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.0.0/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v5.0.0/lambda/mod.ts";
import * as mapping from "https://deno.land/x/denops_std/mapping/mod.ts";
import * as option from "https://deno.land/x/denops_std/option/mod.ts";
import { batch } from "https://deno.land/x/denops_std@v5.0.0/batch/mod.ts";
import { ensureString } from "https://deno.land/x/unknownutil@v2.1.1/ensure.ts";
import { notify } from "../util.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.0/helper/mod.ts";

export const ddc: Plug[] = [
  {
    url: "Shougo/ddc.vim",
    dependencies: [
      { url: "Shougo/ddc-ui-native" },
      { url: "Shougo/ddc-source-around" },
      { url: "LumaKernel/ddc-source-file" },
      { url: "matsui54/ddc-buffer" },
      { url: "Shougo/ddc-source-cmdline-history" },
      { url: "Shougo/ddc-source-line" },
      { url: "Shougo/ddc-source-nvim-lua" },
      { url: "Shougo/ddc-source-rg" },
      { url: "Shougo/ddc-source-nvim-lsp" },
      { url: "Shougo/ddc-filter-matcher_head" },
      { url: "Shougo/ddc-filter-sorter_rank" },
      { url: "tani/ddc-fuzzy" },
      { url: "matsui54/ddc-dictionary" },
      {
        url: "hrsh7th/vim-vsnip",
        dependencies: [
          { url: "hrsh7th/vim-vsnip-integ" },
          { url: "rafamadriz/friendly-snippets" },
        ],
        after: async ({ denops }) => {
          await execute(
            denops,
            `
            " Expand or jump
            imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
            smap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'

            " Jump forward or backward
            imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
            smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
            imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
            smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
            `,
          );
        },
      },
    ],
    after: async ({ denops }) => {
      await denops.call("ddc#custom#patch_global", {
        ui: "native",
        autoCompleteEvents: [
          "InsertEnter",
          "TextChangedI",
          "TextChangedP",
          "CmdlineEnter",
          "CmdlineChanged",
          "TextChangedT",
        ],
        sources: ["nvim-lsp", "around", "file", "vsnip", "rg"],
        sourceOptions: {
          around: { mark: "[Around]" },
          file: { mark: "[File]" },
          buffer: { mark: "[Buffer]" },
          line: { mark: "[Line]" },
          rg: { mark: "[Rg]" },
          "nvim-lsp": {
            mark: "[Lsp]",
            forceCompletionPattern: ".w*|:w*|->w*",
          },
          _: {
            matchers: ["matcher_fuzzy"],
            sorters: ["sorter_fuzzy"],
            converters: ["converter_fuzzy"],
          },
        },
        sourceParams: {
          buffer: {
            requireSameFiletype: false,
            limitBytes: 50000,
            fromAltBuf: true,
            forceCollect: true,
          },
          file: {
            filenameChars: "[:keyword:].",
          },
        },
      });
      await mapping.map(
        denops,
        "<c-space>",
        "<cmd>call ddc#map#manual_complete()<cr>",
        { mode: "i" },
      );
      await denops.call("ddc#enable");
      await notify(denops, "ddc loaded");
    },
  },
];
