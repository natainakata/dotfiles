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
bindkey '^L' autosuggest-accept
[[ -n "${key[Home]}" ]] &&  bindkey "${key[Home]}" __return-home
[[ -n "${key[End]}" ]] && bindkey "${key[End]}" __reload-zsh
