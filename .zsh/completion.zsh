fpath=(${ASDF_DIR}/completions $fpath)

zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''

zstyle ':completion:*:default' menu select=1
eval "$(gh completion -s zsh)"

export PMY_RULE_PATH="$HOME/.pmy"
