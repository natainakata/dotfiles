#!/usr/bin/env zsh
tput cup $LINES

ZINITHOME="$HOME/.zinit"
### Added by Zinit's installer
if [[ ! -f $ZINITHOME/bin/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p $ZINITHOME && command chmod g-rwX $ZINITHOME
    command git clone https://github.com/zdharma-continuum/zinit "$ZINITHOME/bin" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$ZINITHOME/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/z-a-patch-dl \
    zdharma-continuum/z-a-as-monitor \
    zdharma-continuum/z-a-bin-gem-node
### End of Zinit's installer chunk

source $ZINITHOME/bin/zinit.zsh

# shell extention
zinit ice wait lucid atload'_zsh_autosuggest_start'; zinit light zsh-users/zsh-autosuggestions
zinit ice wait'0' blockf atpull'zinit creinstall -q .'; zinit light zsh-users/zsh-completions
zinit ice wait'0'; zinit light zdharma-continuum/fast-syntax-highlighting
# zinit light ryutok/rust-zsh-completions
# zinit ice pick'cli.zsh'; zinit light sudosubin/zsh-github-cli
zinit light chrissicool/zsh-256color
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode
# zinit light chriskempson/base16-shell
# rust cil
zinit light Aloxaf/fzf-tab
# zinit light b4b4r07/enhancd

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# load rc
ZSHHOME="${HOME}/.zsh"
if [ -d $ZSHHOME -a -r $ZSHHOME -a \
  -x $ZSHHOME ]; then
  for i in $ZSHHOME/*; do
    [[ ${i##*/} = *.zsh ]] &&
      [ \( -f $i -o -h $i \) -a -r $i ] && . $i
  done
fi


# if [ -x "$(command -v tmux)" ] && [ -z "${TMUX}" ]; then
#   # get the IDs
#   ID="`tmux list-sessions`"
#   if [[ -z "$ID" ]]; then
#     tmux new-session
#   fi
#   create_new_session="Create New Session"
#   ID="$ID\n${create_new_session}:"
#   ID="`echo $ID | fzf | cut -d: -f1`"
#   if [[ "$ID" = "${create_new_session}" ]]; then
#     tmux new-session
#   elif [[ -n "$ID" ]]; then
#     tmux attach-session -t "$ID"
#   else
#     :  # Start terminal normally
#   fi
# fi

command -v starship > /dev/null && eval "$(starship init zsh)"
command -v gh > /dev/null && eval "$(gh completion -s zsh)"
command -v pyenv > /dev/null && eval "$(pyenv init -)"
command -v keychain > /dev/null && eval $(keychain --eval --quiet id_ed25519)
