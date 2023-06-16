import type { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";

export async function dispatch(denops: Denops): Promise<void> {
  denops.dispatcher = {
    async bufferDeleteSafety(): Promise<unknown> {
      if (await fn.input(denops, "delete buffer? (y/N): ") === "y") {
        await denops.cmd("redraw")
        await denops.cmd("bdelete!")
        return await Promise.resolve("delete buffer!")
      }
    },
  };
}

