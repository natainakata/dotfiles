import { libs } from "./plugins/libs.ts";
import { ui } from "./plugins/ui.ts";
import { ddu } from "./plugins/ddu.ts";
import { ddc } from "./plugins/ddc.ts";
import { lsp } from "./plugins/lsp.ts";
import { coding } from "./plugins/coding.ts";
import { treesitter } from "./plugins/treesitter.ts";

export const plugins = [
  ...libs,
  ...ui,
  ...ddu,
  ...ddc,
  ...coding,
  ...treesitter,
  ...lsp,
];
