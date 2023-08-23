#!/usr/bin/env zsh
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

export EDITOR=nvim
export KEYTIMEOUT=1

export GOPATH=~/.go

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export DENO_INSTALL="/home/natai/.deno"

path=(
  ~/.bin
  ~/bin
  ~/.local/bin
  ~/.local/zig
  $GOPATH/bin
  $DENO_INSTALL/bin
  $path
)


export BAT_THEME="Catppuccin-frappe"
