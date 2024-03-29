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

# FZF Settings
# Sources：https://zenn.dev/yushin_hirano/articles/28e7ea8cd11bc1
# DEFAULT_OPTS

export FZF_COMPLETION_TRIGGER='@@'

# HOMEDIR ESCAPE INSERT
__HOME=$(echo -e $HOME | sed -e "s%/%\\/%g")
if [[ -n ${TMUX-} ]]; then
  typeset -Tgx FZF_DEFAULT_OPTS fzf_default_opts " "
  fzf_default_opts=(
    '--height=40%'
    '--reverse'
    '--inline-info'
    '--prompt="→ "'
    '--margin=0,2'
    '--tiebreak=index'
    '--filepath-word'
    '--ansi'
  )
  export FZF_TMUX_OPTS="-d 15"
  __FZF_CMD="fzf-tmux"
  __FZF_CMD_OPTS=(
      -d
      15
    )
else
  __FZF_CMD="fzf"
  __FZF_CMD_OPTS=()
  typeset -Tgx FZF_DEFAULT_OPTS fzf_default_opts " "
  fzf_default_opts=(
    '--height=70%'
    '--reverse'
    '--border'
    '--inline-info'
    '--prompt="→ "'
    '--margin=0,2'
    '--tiebreak=index'
    '--filepath-word'
    '--ansi'
  )
fi

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'

__FZF_FD_FILES_CMD=(
  fd --type f
)

__FZF_FD_DIRS_CMD=(
  fd --type d
)

__FZF_FD_ALL_OPTS=(
    --hidden --follow --exclude ".git"
)

__FZF_FD_ALL_FILES_CMD=(
    ${__FZF_FD_FILES_CMD[@]}
    ${__FZF_FD_ALL_OPTS[@]}
)

__FZF_FD_ALL_DIRS_CMD=(
    ${__FZF_FD_DIRS_CMD[@]}
    ${__FZF_FD_ALL_OPTS[@]}
)

__FZF_DIR_PREVIEW_CMD=(
    lsd
    --icon=always
    --color=never
    --almost-all
    '{}'
    '|'
    head -n 100
)

__FZF_FILE_PREVIEW_CMD=(
    bat
    --style=numbers
    --color=always
    --line-range :100
    '{}'
)


export FZF_ALT_C_OPTS="--prompt='dirs > ' --no-multi --preview '${__FZF_DIR_PREVIEW_CMD[*]}'
            --header=$'Press CTRL-A: --hidden --follow, Ctrl-D: default\n\n'
            --bind 'ctrl-d:change-prompt(dirs > )+reload(${__FZF_FD_DIRS_CMD[*]} .)'
            --bind 'ctrl-a:change-prompt(all dirs > )+reload(${__FZF_FD_ALL_DIRS_CMD[*]} .)'"
export FZF_ALT_C_COMMAND="${__FZF_FD_DIRS_CMD[*]}"

export FZF_CTRL_T_OPTS="--prompt='files → ' --preview '${__FZF_FILE_PREVIEW_CMD[*]}'
            --header=$'Press CTRL-A: --hidden --follow, Ctrl-D: default\n\n'
            --bind 'ctrl-d:change-prompt(files > )+reload(${__FZF_FD_FILES_CMD[*]} .)'
            --bind 'ctrl-a:change-prompt(all files > )+reload(${__FZF_FD_ALL_FILES_CMD[*]} .)'"
export FZF_CTRL_T_COMMAND="${__FZF_FD_FILES_CMD[*]}"

# FZF FUNCTIONS
function __fzf-cdr() {
  # ~ ESCAPE
  local selected_dir=$(cdr -l | awk '{ print $2 }' | sed -e "s%~%${__HOME}%g" | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --preview="echo -e {} | ${__FZF_DIR_PREVIEW_CMD[*]}" --prompt="cdr → " --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    local BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N __fzf-cdr
bindkey '^O' __fzf-cdr

function __fzf-git-switch() {
  local target_br=$(
    git branch |
      ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --exit-0 --layout=reverse --info=hidden --no-multi \
      --prompt="git branch → " \
      --header=$'Press Ctrl-A: --all, Ctrl-D: default\n\n' \
      --bind "ctrl-d:change-prompt(git branch →  )+reload(git branch)" \
      --bind "ctrl-a:change-prompt(git branch --all > )+reload(git branch --all | grep -v 'remotes/origin/HEAD')" \
      --preview-window="right,65%" \
      --preview="echo -e {} | tr -d ' *' | xargs git log --graph --decorate --abbrev-commit --format=format:'%C(blue)%h%C(reset) - %C(green)(%ar)%C(reset)%C(yellow)%d%C(reset)'$'\n'' %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --color=always" | \
      head -n 1 | \
      perl -pe "s/\s//g; s/\*//g; s/remotes\/origin\///g"
  )

  if [ -n "$target_br" ]; then
    local BUFFER="git switch $target_br"
  fi
  zle accept-line
}
zle -N __fzf-git-switch

function __fzf-git-add() {
  local target_add=$(
    unbuffer git status -s  |
      ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} -m --preview="echo {} | awk '{ print \$2 }' | xargs git diff --color | bat --style=numbers " --prompt="git add → " | awk '{ print $2 }'
  )
  if [ -n "$target_add" ]; then
    target_add=$(tr '\n' ' ' <<< "$target_add")
    local BUFFER="git add $target_add"
    zle accept-line
  fi
}
zle -N __fzf-git-add

function __fzf-history() {
  local BUFFER=$(history -n -r 1 | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --prompt="cmd history → " --no-sort --query "$LBUFFER")
  local CURSOR=$#BUFFER
  zle accept-line
}
zle -N __fzf-history

function __fzf-src() {
  local src=$(ghq list --full-path | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --preview="echo {} | ${__FZF_DIR_PREVIEW_CMD[*]}" --prompt="src → " --query "$LBUFFER")
  if [ -n "$src" ]; then
    BUFFER="cd $src"
    zle accept-line
  fi
  zle -R -c
}
zle -N __fzf-src

function __fzf-edit() {
files=$(lsd --almost-all | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --preview="echo -e {} | awk '{ print substr(\$1, 2) }' | fzf-preview-check {}" --prompt="edit → " -m --query "$LBUFFER")
  if [ -n "$files" ]; then
    BUFFER="${EDITOR} ${files[@]}"
    zle accept-line
  fi
}
zle -N __fzf-edit

function __fzf-tmux() {
  if [ -n "$TMUX" ]; then
    local sessions=$(tmux list-sessions | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --prompt="sessions → " -m --query "$LBUFFER" | cut -d : -f 1)
    if [ -n "$sessions" ]; then
      tmux switch -t $sessions
    fi
  fi
}
zle -N __fzf-tmux

#local __FZF_COMMANDS_LIST=(
#fzf-cdr
#fzf-git-switch
#fzf-history
#fzf-src
#fzf-edit
#fzf-tmux
#fzf-git-add
#)

local -A __FZF_COMMANDS
__FZF_COMMANDS=(
  [c]=fzf-cdr
  [b]=fzf-git_switch
  [h]=fzf-history
  [s]=fzf-src
  [e]=fzf-edit
  [t]=fzf-tmux
  [a]=fzf-git_add
)

function __fzf-awaken() {
  local prefix=${LBUFFER[-1]}
  zle backward-delete-word
  if [[ -n "$prefix" && -n "${__FZF_COMMANDS[(i)${prefix}]}" ]]; then
    zle "__${__FZF_COMMANDS[${prefix}]}"
  fi
  zle redisplay
}

zle -N __fzf-awaken

bindkey '^R' __fzf-history
bindkey '^ ' __fzf-awaken
bindkey '^O' __fzf-cdr

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
