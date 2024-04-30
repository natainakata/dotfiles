# option settings
HISTSIZE=100000
SAVEHIST=1000000

setopt incappendhistory
setopt sharehistory

setopt autocd
setopt noflowcontrol
setopt autopushd
setopt pushdignoredups
setopt print_eight_bit
setopt extendedglob
setopt autoparamkeys
setopt notify
setopt mark_dirs
# setopt correct
# setopt correct_all
setopt no_clobber
setopt noautoremoveslash

bindkey -e

function __bash-ctrl-d() {
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
zle -N bash-ctrl-d __bash-ctrl-d
bindkey -M emacs "^d" bash-ctrl-d


