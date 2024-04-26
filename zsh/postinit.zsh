zoxide_cache="/tmp/zoxide_cache.zsh"
if [[ ! -r "$zoxide_cache" ]]; then
  zoxide init zsh > $zoxide_cache
fi
source $zoxide_cache
unset zoxide_cache


autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

if [[ ! -r $ZSHRC_DIR/functions/_gh ]]; then
  gh completion -s zsh > $ZSHRC_DIR/functions/_gh
fi

if [[ ! -r $ZSHRC_DIR/functions/_mise ]] then
  mise completion zsh > $ZSHRC_DIR/functions/_mise
fi


zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''

zstyle ':completion:*:default' menu select=1

zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
bindkey '^F' autosuggest-accept

export IGNOREEOF=2
setopt ignore_eof
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end


