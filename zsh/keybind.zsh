typeset -fuz zkbd

if [[ -f ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE} ]]; then
  source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
fi

__return-home() {
  BUFFER="cd"
  zle accept-line
  zle redisplay
}
__reload-zsh() {
  BUFFER="source $HOME/.zshrc"
  zle accept-line
  zle redisplay
}

zle -N __return-home
zle -N __reload-zsh

bindkey -e
bindkey '^F' autosuggest-accept
[[ -n "${key[Home]}" ]] &&  bindkey "${key[Home]}" __return-home
[[ -n "${key[End]}" ]] && bindkey "${key[End]}" __reload-zsh

export IGNOREEOF=2
setopt ignore_eof
function bash-ctrl-d() {
  if [[ $CURSOR == 0 && -z $BUFFER ]]
  then
    [[ -z $IGNOREEOF || $IGNOREEOF == 0 ]] && exit
    if [[ "$LASTWIDGET" == "bash-ctrl-d" ]]
    then
      (( --__BASH_IGNORE_EOF <= 0 )) && exit
    else
      (( __BASH_IGNORE_EOF = IGNOREEOF ))
    fi
  fi
}
zle -N bash-ctrl-d
bindkey "^d" bash-ctrl-d

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
