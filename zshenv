#!/usr/bin/env zsh
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

export EDITOR=nvim
export ENHANCD_COMMAND=ecd
export KEYTIMEOUT=1

export GOPATH=~/.go

# export STARSHIP_CONFIG="$HOME/.dotfiles/starship.toml"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

path=(
  ~/.bin
  ~/bin
  ~/.local/bin
  ~/.local/zig
  $GOPATH/bin
  $path
)
# . "$HOME/.cargo/env"
