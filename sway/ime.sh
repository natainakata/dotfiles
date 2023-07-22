#!/usr/bin/env bash

wezterm --config initial_rows=10 --config initial_cols=80 --config enable_tab_bar=false --config window_background_opacity=0.7 start --class FloatingVim nvim /tmp/clip.ime || exit 1

if [[ -e /tmp/clip.ime ]]; then
  head -c -1 /tmp/clip.ime | wl-copy
  rm f /tmp/clip.ime
fi
