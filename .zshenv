export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

export EDITOR=${commands[nvim]:-"vim"}
# export PMY_TRIGGER_KEY="^y"
export ENHANCD_COMMAND=ecd
export KEYTIMEOUT=1

export GOPATH=~/.go

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
