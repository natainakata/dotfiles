# starship_config_dir="$ZSHRC_DIR/starship"
# starship_cache="$starship_config_dir/starship.zsh"
# export STARSHIP_CONFIG="$starship_config_dir/starship.toml"
# if [[ ! -r "$starship_cache" || "$STARSHIP_CONFIG" -nt "$starship_cache" ]]; then
#   starship init zsh --print-full-init > $starship_cache
# fi
# source $starship_cache
# unset starship_cache starship_config_dir


rtx_config="$XDG_CONFIG_HOME/rtx/config.toml"
rtx_cache="/tmp/rtx_cache.zsh"
if [[ ! -r "$rtx_cache" ]]; then
  mise activate zsh > $rtx_cache
fi
source $rtx_cache
unset rtx_cache rtx_config

zoxide_cache="/tmp/zoxide_cache.zsh"
if [[ ! -r "$zoxide_cache" ]]; then
  zoxide init zsh --hook prompt > $zoxide_cache
fi
source $zoxide_cache
unset zoxide_cache

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

export __ENABLE_TMUX=

if [ -x "$(command -v tmux)" ] && [ -z "${TMUX}" ] && [ -n "${__ENABLE_TMUX}" ]; then
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
