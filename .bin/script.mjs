#!/usr/bin/env zx
console.log("Hello zx!");

let count = parseInt(await $`ls -1 | wc -l`)
console.log(`Files count: ${count}`);
