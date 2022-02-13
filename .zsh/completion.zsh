fpath=(${ASDF_DIR}/completions $fpath)

zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''

zstyle ':completion:*:default' menu select=1

# export PMY_RULE_PATH="$HOME/.pmy"

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always  $realpath'
zstyle ':fzf-tab:complete:nvim:*' fzf-preview 'bat --color=always $realpath'
zstyle ':fzf-tab:*' fzf-pad 4
