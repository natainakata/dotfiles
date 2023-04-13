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
zinit light ryutok/rust-zsh-completions
zinit ice pick'cli.zsh'; zinit light sudosubin/zsh-github-cli
zinit light chrissicool/zsh-256color
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode
# zinit light chriskempson/base16-shell
# rust cil
zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"; zinit light sharkdp/bat
zinit ice as"program" from"gh-r" mv"fd* -> fd" pick"fd/fd"; zinit light sharkdp/fd
zinit ice as"program" from"gh-r" pick"lsd*/lsd"; zinit light Peltoche/lsd
zinit ice as"program" from"gh-r" mv"hexyl* -> hexyl" pick"hexyl/hexyl"; zinit light sharkdp/hexyl
zinit ice as"program" from"gh-r" pick"delta*/delta"; zinit light dandavison/delta
zinit ice as"program" from"gh-r" pick"ripgrep*/rg"; zinit light BurntSushi/ripgrep
zinit wait'1' lucid \
  from"gh-r" as"program" mv"tealdeer-* -> tldr" pick"tldr" \
  light-mode for @dbrgn/tealdeer
zinit ice wait'1' lucid as"completion" mv'zsh_tealdeer -> _tldr'
zinit ice as"program" from"gh-r" \
  pick"zoxide*/zoxide" \
  atload'eval "$(zoxide init zsh)"'
zinit light ajeetdsouza/zoxide
zinit ice as"program" from"gh-r" \
  pick"starship*/starship" \
  atload'eval "$(starship init zsh)"'
zinit light starship/starship
# fzf
zinit ice atclone"./install"; zinit light junegunn/fzf
zinit light Aloxaf/fzf-tab
zinit light b4b4r07/enhancd

zinit ice as"program" from"gh-r" mv"win32yank* - win32yank" pick"equalsraf/win32yank"; zinit light equalsraf/win32yank

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ ! -n $TMUX && $- == *l* ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | fzf | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi
if [[ -n ${TMUX-} ]]; then
  export TERM=tmux-256color
fi

# . $HOME/.asdf/asdf.sh
# fpath=(~/.asdf/completions $fpath)

# load rc
ZSHHOME="${HOME}/.zsh"
if [ -d $ZSHHOME -a -r $ZSHHOME -a \
  -x $ZSHHOME ]; then
  for i in $ZSHHOME/*; do
    [[ ${i##*/} = *.zsh ]] &&
      [ \( -f $i -o -h $i \) -a -r $i ] && . $i
  done
fi

eval "$(gh completion -s zsh)"


