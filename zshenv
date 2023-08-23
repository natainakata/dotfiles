#!/usr/bin/env zsh
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

export EDITOR=nvim
export KEYTIMEOUT=1

export GOPATH=~/.go

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export NEOVIM_HOME="$HOME/.local/nvim"
if [ -d "${NEOVIM_HOME}" ]; then
  export PATH="${NEOVIM_HOME}/bin:$PATH"
fi

path=(
  ~/.bin
  ~/bin
  ~/.local/bin
  ~/.local/zig
  $GOPATH/bin
  $path
)

# . "$HOME/.cargo/env"

export DENO_INSTALL="/home/natai/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export BAT_THEME="Catppuccin-frappe"
