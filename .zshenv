export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

export EDITOR=nvim
# export PMY_TRIGGER_KEY="^y"
export ENHANCD_COMMAND=ecd
export KEYTIMEOUT=1

export GOPATH=~/.go

export STARSHIP_CONFIG="$HOME/.dotfiles/starship.toml"

path=(
  ~/.bin
  ~/bin
  ~/.local/bin
  ~/.deno/bin
  $GOPATH/bin
  $path
  /usr/local/zig
)

. "$HOME/.cargo/env"

