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

export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

export EDITOR=nvim
export BAT_THEME="OneHalfDark"
export KEYTIMEOUT=1

path=(
  ~/.bin
  ~/bin
  ~/.local/bin
  $GOPATH/bin
  $path
)

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


