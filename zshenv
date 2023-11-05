#!/usr/bin/env zsh
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

export EDITOR=nvim
export BAT_THEME="Catppuccin-frappe"
export KEYTIMEOUT=1

export GOPATH=~/.go

export DENO_INSTALL="/home/natai/.deno"
export PYENV_ROOT="$HOME/.pyenv"
export AQUA_GLOBAL_CONFIG="$HOME/.config/aqua/aqua.yaml"
export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"
export __ENABLE_TMUX=

path=(
  ~/.bin
  ~/bin
  ~/.local/bin
  ~/.local/zig
  $GOPATH/bin
  $DENO_INSTALL/bin
  $PYENV_ROOT/bin
  $path
)

# source "$HOME/.keychain/nataiarch-sh"
