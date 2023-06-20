import type { Plug } from "https://deno.land/x/dvpm@1.0.0/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.0.0/mapping/mod.ts";
import { notify } from "../util.ts";

export const ui: Plug[] = [
  {
    url: "navarasu/onedark.nvim",
    after: async ({ denops }) => {
      await denops.cmd(`lua require("onedark").setup({transparent = true})`);
      await denops.cmd("colorscheme onedark");
    },
  },
  {
    url: "folke/noice.nvim",
    dependencies: [
      { url: "rcarriga/nvim-notify" },
    ],
    before: async ({ denops }) => {
      await mapping.map(
        denops,
        "<C-Enter>",
        `lua require("noice").redirect(vim.fn.getcmdline())`,
        {
          mode: "c",
        },
      );
      await mapping.map(
        denops,
        "<leader>nl",
        `lua require("noice").cmd("last")`,
        {
          mode: "n",
        },
      );
      await mapping.map(
        denops,
        "<leader>nh",
        `lua require("noice").cmd("history")`,
        {
          mode: "n",
        },
      );
      await mapping.map(
        denops,
        "<leader>nh",
        `lua require("noice").cmd("all")`,
        {
          mode: "n",
        },
      );
    },
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require("noice").setup(_A.param)`,
        {
          param: {
            lsp: {
              override: {
                ["vim.lsp.util.convert_input_to_markdown_lines"]: true,
                ["vim.lsp.util.stylize_markdown"]: true,
              },
            },
            presets: {
              bottom_search: true,
              command_palette: true,
              long_message_to_split: true,
            },
          },
        },
      );
      await notify(denops, "noice loaded");
    },
  },
  {
    url: "folke/which-key.nvim",
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require("which-key").setup()`,
      );
      await notify(denops, "whichkey loaded");
    },
  },
  {
    url: "petertriho/nvim-scrollbar",
    after: async ({ denops }) => {
      await denops.cmd(
        `lua require("scrollbar").setup()`,
      );
    },
  },
  {
    url: "nvim-lualine/lualine.nvim",
    dependencies: [{
      url: "SmiteshP/nvim-navic",
    }],
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require("lualine").setup(_A.param)`,
        {
          param: {
            options: {
              theme: "auto",
              globalstatus: true,
              section_separators: { left: "", right: "" },
              component_separators: { left: "", right: "" },
            },
            sections: {
              lualine_a: ["mode"],
              lualine_b: ["filename", { newfile_status: true }, { path: 1 }, {
                shorting_target: 24,
              }],
              lualine_c: ["diagnostics", {
                sources: ["nvim_diagnostic", "nvim_lsp"],
              }, {
                sections: ["error", "warn", "info", "hint"],
              }],
              lualine_x: ["encoding"],
              lualine_y: ["filetype"],
              lualine_z: ["fileformat", { icons_enabled: true }, {
                separator: { left: "", right: "" },
              }],
            },
            tabline: {
              lualine_a: ["buffers"],
              lualine_b: [],
              lualine_c: [
                "navic",
                { color_correction: "static" },
                {
                  navic_opts: {
                    depth_limit: 9,
                  },
                },
              ],
              lualine_x: [
                "diff",
              ],
              lualine_y: [
                "b:gitsigns_head",
              ],
              lualine_z: ["tabs"],
            },
            extensions: [
              "man",
              "quickfix",
              "symbols-outline",
            ],
          },
        },
      );
      await notify(denops, "lualine loaded");
    },
  },
  {
    url: "kevinhwang91/nvim-hlslens",
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `
        require("hlslens").setup()
        `,
      );
    },
  },
  {
    url: "lewis6991/gitsigns.nvim",
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `
        require("gitsigns").setup()
        `,
      );
    },
  },
  {
    url: "echasnovski/mini.indentscope",
    after: async ({ denops }) => {
      await denops.cmd(`lua require("mini.indentscope").setup()`);
    },
  },
];
