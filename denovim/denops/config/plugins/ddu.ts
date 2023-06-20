import type { Plug } from "https://deno.land/x/dvpm@1.0.0/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.0.0/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v5.0.0/lambda/mod.ts";
import * as mapping from "https://deno.land/x/denops_std/mapping/mod.ts";
import * as option from "https://deno.land/x/denops_std/option/mod.ts";
import { batch } from "https://deno.land/x/denops_std@v5.0.0/batch/mod.ts";
import { notify } from "../util.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.0/helper/mod.ts";

export const ddu: Plug[] = [
  {
    url: "Shougo/ddu.vim",
    dependencies: [
      { url: "Shougo/ddu-commands.vim" },
      { url: "Shougo/ddu-ui-ff" },
      { url: "Shougo/ddu-ui-filer" },
      // {
      //   "url": "matsui54/ddu-vim-ui-select",
      //   enabled: async ({ denops }) => (await fn.has(denops, "nvim")) && false,
      // },
      { url: "4513ECHO/ddu-source-emoji" },
      { url: "4513ECHO/ddu-source-source" },
      { url: "4513ECHO/vim-readme-viewer" },
      { url: "Shougo/ddu-source-action" },
      { url: "Shougo/ddu-column-filename" },
      { url: "Shougo/ddu-source-file" },
      { url: "Shougo/ddu-source-file_old" },
      { url: "Shougo/ddu-source-file_rec" },
      { url: "Shougo/ddu-source-line" },
      { url: "Shougo/ddu-source-register" },
      { url: "kyoh86/ddu-source-command" },
      { url: "matsui54/ddu-source-command_history" },
      { url: "matsui54/ddu-source-file_external" },
      { url: "matsui54/ddu-source-help" },
      { url: "shun/ddu-source-rg" },
      { url: "gamoutatsumi/ddu-source-nvim-lsp" },
      { url: "uga-rosa/ddu-source-search_history" },
      { url: "shun/ddu-source-buffer" },
      { url: "yuki-yano/ddu-filter-fzf" },
      { url: "kuuote/ddu-filter-fuse" },
      { url: "uga-rosa/ddu-filter-converter_devicon" },
      { url: "Shougo/ddu-kind-file" },
      { url: "Shougo/ddu-kind-word" },
      { url: "4513ECHO/ddu-kind-url" },
      // {
      //   url: "matsui54/ddu-vim-ui-select",
      //   enabled: async ({ denops }) => (await fn.has(denops, "nvim")) && false,
      // },
    ],
    enabled: async ({ denops }) => await fn.has(denops, "nvim"),
    before: async ({ denops }) => {
      await mapping.map(denops, "q:", "<Cmd>Ddu command_history<CR>", {
        mode: "n",
      });
      await mapping.map(denops, "q/", "<Cmd>Ddu search_history<CR>", {
        mode: "n",
      });
      await mapping.map(
        denops,
        "<Leader>b",
        "<Cmd>Ddu -name=Buffers buffer<CR>",
        {
          mode: "n",
        },
      );
      await mapping.map(
        denops,
        "<Leader>f",
        "<Cmd>Ddu -name=Files file_rec<CR>",
        {
          mode: "n",
        },
      );
      await mapping.map(
        denops,
        "<Leader>r",
        "<Cmd>Ddu -name=Mru file_old<CR>",
        {
          mode: "n",
        },
      );
      await mapping.map(
        denops,
        "<Leader>/",
        "<Cmd>Ddu -name=Lines line<CR>",
        {
          mode: "n",
        },
      );
      await mapping.map(
        denops,
        "<Leader>*",
        `<cmd>call <SID>${denops.name}_notify("${
          lambda.register(
            denops,
            async () => {
              await denops.call("ddu#start", {
                name: "RgLive",
                sources: [
                  {
                    name: "rg",
                    options: {
                      matchers: [],
                      volatile: true,
                    },
                  },
                ],
                uiParams: {
                  ff: {
                    ignoreEmpty: false,
                    autoResize: false,
                  },
                },
              });
            },
          )
        }", [])<CR>`,
        {
          mode: "n",
        },
      );
      await mapping.map(
        denops,
        '<Leader>"',
        "<Cmd>Ddu -name=Register register<CR>",
        {
          mode: "n",
        },
      );
      await mapping.map(
        denops,
        "<Leader>?",
        "<Cmd>Ddu -name=Help help<CR>",
        {
          mode: "n",
        },
      );
      await mapping.map(
        denops,
        "<Leader>e",
        `<cmd>call <SID>${denops.name}_notify("${
          lambda.register(
            denops,
            async () => {
              await denops.call("ddu#start", {
                name: "File exploler",
                ui: "filer",
                sources: [
                  {
                    name: "file",
                    params: {},
                  },
                ],
              });
            },
          )
        }", [])<CR>`,
        { mode: "n" },
      );
    },
    after: async ({ denops }) => {
      const lines = await option.lines.get(denops);
      const [height, row] = [
        Math.floor(lines * 0.85),
        Math.floor(lines * 0.075),
      ];
      const columns = await option.columns.get(denops);
      const [width, col] = [
        Math.floor(columns * 0.85),
        Math.floor(columns * 0.075),
      ];
      await denops.call("ddu#custom#patch_global", {
        ui: "ff",
        uiOptions: {
          filer: { toggle: true },
        },
        uiParams: {
          ff: {
            filterFloatingPosition: "top",
            filterSplitDirection: "floating",
            floatingBorder: "single",
            previewFloating: true,
            previewFloatingBorder: "single",
            previewFloatingTitle: "Preview",
            previewSplit: "vertical",
            previewWidth: Math.floor(width / 2),
            split: "floating",
            winCol: col,
            winHeight: height,
            winRow: row,
            winWidth: width,
            highlights: {
              floating: "Normal",
              floatingBorder: "Normal",
            },
            prompt: "»",
            startFilter: true,
            autoAction: {
              name: "preview",
            },
          },
          filer: {
            split: "vertical",
            sort: "filename",
            splitDirection: "topleft",
            sortTreesFirst: true,
            previewSplit: "no",
            toggle: true,
            winWidth: 30,
          },
        },
        sourceOptions: {
          _: {
            ignoreCase: true,
            matchers: ["matcher_fzf"],
            // sorters: ["sorter_fzf"],
            converters: ["converter_devicon"],
          },
        },
        sourceParams: {
          rg: {
            args: ["--column", "--no-heading", "--color", "never"],
          },
        },
        sources: [{
          name: "file_rec",
          params: {},
        }],
        kindOptions: {
          _: {
            defaultAction: "open",
          },
          command_history: {
            defaultAction: "execute",
          },
          search_history: {
            defaultAction: "execute",
          },
        },
        filterParams: {
          matcher_fzf: { highlightMatched: "Search" },
        },
      });

      const mappings = lambda.register(
        denops,
        async () => {
          await batch(denops, async (denops) => {
            await mapping.map(
              denops,
              "<cr>",
              `<cmd>call ddu#ui#do_action('itemAction')<cr>`,
              { mode: "n", buffer: true, silent: true },
            );
            await mapping.map(
              denops,
              "<space>",
              `<cmd>call ddu#ui#do_action('toggleSelectItem')<cr>`,
              { mode: "n", buffer: true, silent: true },
            );
            await mapping.map(
              denops,
              "i",
              `<cmd>call ddu#ui#do_action('openFilterWindow')<cr>`,
              { mode: "n", buffer: true, silent: true },
            );
            await mapping.map(
              denops,
              "<C-c>",
              `<cmd>call ddu#ui#do_action('quit')<cr>`,
              { mode: "n", buffer: true, silent: true },
            );
            await mapping.map(
              denops,
              "<Esc>",
              `<cmd>call ddu#ui#do_action('quit')<cr>`,
              { mode: "n", buffer: true, silent: true },
            );
          });
        },
      );

      const filtermappings = lambda.register(
        denops,
        async () => {
          await batch(denops, async (denops) => {
            await mapping.map(
              denops,
              "<cr>",
              `<esc><cmd>call ddu#ui#do_action('itemAction')<cr>`,
              { mode: "i", buffer: true, silent: true },
            );
            await mapping.map(
              denops,
              "<esc>",
              "<Esc><cmd>call ddu#ui#do_action('closeFilterWindow')<cr>",
              { mode: "n", buffer: true, silent: true, nowait: true },
            );
            await mapping.map(
              denops,
              "jj",
              "<Esc><cmd>call ddu#ui#do_action('closeFilterWindow')<cr>",
              { mode: "n", buffer: true, silent: true, nowait: true },
            );
            await mapping.map(
              denops,
              "<C-c>",
              `<Esc><Cmd>call ddu#ui#do_action('quit')<CR>`,
              { mode: "i", buffer: true, silent: true, nowait: true },
            );
          });
        },
      );

      const filermappings = lambda.register(
        denops,
        async () => {
          await batch(denops, async (denops) => {
            await execute(
              denops,
              `nnoremap <buffer><expr> <cr>
               \\ ddu#ui#get_item()->get('isTree', v:false) ?
               \\ "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'narrow'})<CR>" :
               \\ "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open'})<CR>"`,
            );
            await mapping.map(
              denops,
              "<space>",
              `<cmd>call ddu#ui#do_action('toggleSelectItem')<cr>`,
              { mode: "n", buffer: true, silent: true, nowait: true },
            );
            await mapping.map(
              denops,
              "o",
              `<esc><cmd>call ddu#ui#do_action('expandItem', {'mode': 'toggle'})<cr>`,
              { mode: "n", buffer: true, silent: true, nowait: true },
            );
            await mapping.map(
              denops,
              "q",
              `<Cmd>call ddu#ui#do_action('quit')<CR>`,
              { mode: "n", buffer: true, silent: true, nowait: true },
            );
          });
        },
      );

      await autocmd.group(denops, "natai_DduMapping", (helper) => {
        helper.remove("*");
        helper.define(
          "FileType",
          "ddu-ff",
          `call denops#notify('${denops.name}', '${mappings}', [])`,
        );
        helper.define(
          "FileType",
          "ddu-ff-filter",
          `call denops#notify('${denops.name}', '${filtermappings}', [])`,
        );
        helper.define(
          "FileType",
          "ddu-filer",
          `call denops#notify('${denops.name}', '${filermappings}', [])`,
        );
      });
      await notify(denops, "ddu loaded");
    },
  },
];
