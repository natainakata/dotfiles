import type { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@1.0.0/mod.ts";

import { Dvpm } from "https://deno.land/x/dvpm@1.0.0/mod.ts";

import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";
import { ensureString } from "https://deno.land/x/unknownutil@v2.1.1/mod.ts";
import { setOption } from "./option.ts";
import { dispatch } from "./command.ts";
import { setKeymapPost, setKeymapPre } from "./keymap.ts";
import { plugins } from "./plugins.ts";

export async function main(denops: Denops): Promise<void> {
  const starttime = performance.now();
  await pre(denops);
  await dvpmExec(denops);
  await post(denops);
  const elapsed = performance.now() - starttime;
  denops.cmd(
    `lua vim.notify("Config load completed ! Elapsed: (${elapsed})")`,
    { elapsed },
  );
}

async function pre(denops: Denops): Promise<void> {
  await setOption(denops);
  await setKeymapPre(denops);
  await dispatch(denops);
}

async function post(denops: Denops): Promise<void> {
  await setKeymapPost(denops);
}

async function dvpmExec(denops: Denops) {
  const base_path = (await fn.has(denops, "nvim"))
    ? "~/.cache/denovim/dvpm"
    : "~/.cache/vim/dvpm";

  const base = ensureString(await fn.expand(denops, base_path));
  const dvpm = await Dvpm.begin(denops, {
    base,
    debug: false,
    profile: false,
    notify: true,
    concurrency: 13,
    logarg: [],
  });

  await Promise.all(plugins.map((p: Plug) => dvpm.add(p)));

  await dvpm.end();
}