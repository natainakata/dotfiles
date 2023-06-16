import type { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.0.0/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";
import * as nvimOption from "https://deno.land/x/denops_std@v5.0.0/option/nvim/mod.ts";
import * as option from "https://deno.land/x/denops_std@v5.0.0/option/mod.ts";
import { batch } from "https://deno.land/x/denops_std@v5.0.0/batch/batch.ts";
import { ensureDir } from "https://deno.land/std@0.191.0/fs/ensure_dir.ts";
import { ensureString } from "https://deno.land/x/unknownutil@v2.1.1/ensure.ts";
import { stdpath } from "https://deno.land/x/denops_std@v5.0.0/function/nvim/mod.ts";

export async function setOption(denops: Denops) {
  const backupdir = (await fn.has(denops, "nvim"))
    ? ensureString(await stdpath(denops, "cache"))
    : ensureString(await fn.expand(denops, "~/.cache/vim/back"));
  await ensureDir(backupdir);

  await batch(denops, async (denops: Denops) => {
    await option.encoding.set(denops, "utf-8");
    await option.fileencodings.set(
      denops,
      "utf-8",
    );
    await option.fileformats.set(denops, "unix,dos,mac");

    await option.backup.set(denops, true);
    await option.backupdir.set(denops, backupdir);
    await option.completeopt.set(denops, "menu,menuone,noselect");
    await option.confirm.set(denops, true);
    await option.expandtab.set(denops, true);
    await option.smartindent.set(denops, true);
    await option.tabstop.set(denops, 2);
    await option.shiftwidth.set(denops, 2);
    await option.grepformat.set(denops, "%f:%l:%c:%m");
    await option.grepprg.set(denops, "rg --vimgrep");
    await option.hidden.set(denops, true);
    await option.ignorecase.set(denops, true);
    await option.list.set(denops, true);
    await option.listchars.set(
      denops,
      "tab:\¦\ ,trail:-,extends:»,precedes:«,nbsp:%",
    );

    await option.mouse.set(denops, "a");
    await option.number.set(denops, true);
    await option.hlsearch.set(denops, true);
    await option.smartcase.set(denops, true);
    await option.wrapscan.set(denops, true);
    await option.termguicolors.set(denops, true);
    await option.cursorline.set(denops, true);
    await option.visualbell.set(denops, true);
    await option.wildmode.set(denops, "list,longest");
    await option.cmdwinheight.set(denops, 10);

    if (await fn.has(denops, "nvim")) {
      await nvimOption.inccommand.set(denops, "nosplit");
      await nvimOption.pumblend.set(denops, 10);
      await option.laststatus.set(denops, 3);
      await option.clipboard.set(denops, "unnamed,unnamedplus");
      await option.cmdheight.set(denops, 0);
    }

    await autocmd.group(denops, "natai_highlight_yank", (helper) => {
      helper.remove("*");
      helper.define(
        "TextYankPost",
        "*",
        `lua vim.highlight.on_yank()`,
      );
    });
    await autocmd.group(denops, "natai_term_insert_in", (helper) => {
      helper.remove("*");
      helper.define(
        "TermOpen",
        "*",
        `
        setlocal nonumber 
        startinsert
        `,
      );
    });
    await autocmd.group(denops, "natai_close_with_q", (helper) => {
      helper.remove("*");
      helper.define(
        "FileType",
        [
          "qf",
          "help",
          "man",
          "notify",
          "lspinfo",
          "startuptime",
        ],
        `let v:event.buf.buflisted = false
          nnoremap <buffer> <silent> q <Cmd>close<CR>`,
      );
    });
    await autocmd.group(denops, "natai_cmdwinclose", (helper) => {
      helper.remove("*");
      helper.define(
        "CmdwinEnter",
        "*",
        `let v:event.buf.buflisted = false
            nnoremap <buffer> <silent> q <Cmd>close<CR>`,
      );
    });
    await autocmd.group(denops, "natai_qf_position", (helper) => {
      helper.remove("*");
      helper.define(
        "FileType",
        "qf",
        `wincmd H`,
      );
    });
    await autocmd.group(denops, "natai_vimgrep_autoopen", (helper) => {
      helper.remove("*");
      helper.define(
        "QuickFixCmdPost",
        "vimgrep",
        `cw
          set modifiable
          vertical resize 30
        `,
      );
    });
  });
}
