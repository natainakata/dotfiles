export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

export EDITOR=${commands[nvim]:-"vim"}
export PMY_TRIGGER_KEY="^P"

path=(
  ~/.bin
  ~/bin
  ~/.local/bin
  ~/.deno/bin
  $path
)

. "$HOME/.cargo/env"
