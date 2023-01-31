# Sources：https://zenn.dev/yushin_hirano/articles/28e7ea8cd11bc1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# DEFAULT_OPTS
export FZF_COMPLETION_TRIGGER='@@'
# HOMEDIR ESCAPE INSERT
__HOME=$(echo -e $HOME | sed -e "s%/%\\/%g")
if [[ -n ${TMUX-} ]]; then
  typeset -Tgx FZF_DEFAULT_OPTS fzf_default_opts " " 
  fzf_default_opts=(
    '--height=70%'
    '--reverse'
    '--inline-info'
    '--prompt="→ "'
    '--margin=0,2'
    '--tiebreak=index'
    '--filepath-word'
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
__fzf-cdr() {
  # ~ ESCAPE
  local selected_dir=$(cdr -l | awk '{ print $2 }' | sed -e "s%~%${__HOME}%g" | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --preview="echo -e {} | ${__FZF_DIR_PREVIEW_CMD[*]}" --prompt="cdr → " --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    local BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N __fzf-cdr

__fzf-git-switch() {
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

__fzf-git-add() {
  local target_add=$(
    git status -s |
      awk '{ print $2 }' |
      ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} -m --preview="${__FZF_FILE_PREVIEW_CMD[*]}" --prompt="git add → " |
      sed -z "s/\n/ /g"
  )
  if [ -n "$target_add" ]; then
    local BUFFER="git add $target_add"
    zle accept-line
  fi
}
zle -N __fzf-git-add

__fzf-history() {
  local BUFFER=$(history -n -r 1 | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --prompt="cmd history → " --no-sort +m --query "$LBUFFER")
  local CURSOR=$#BUFFER
}
zle -N __fzf-history

__fzf-src() {
  local src=$(ghq list --full-path | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --prompt="src → " +m --query "$LBUFFER")
  if [ -n "$src" ]; then
    BUFFER="cd $src"
    zle accept-line
  fi
  zle -R -c
}
zle -N __fzf-src

__fzf-tmux() {
  ID="`tmux list-sessions`"
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --prompt="sessions → " +m --query "$LBUFFER" | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
}
zle -N __fzf-tmux


local -A __FZF_COMMANDS

__FZF_COMMANDS=(
  [c]=fzf-cdr
  [b]=fzf-git-switch
  [h]=fzf-history
  [s]=fzf-src
  [t]=fzf-tmux
  [a]=fzf-git-add
)
__fzf-aweken() {
  local prefix=${LBUFFER[-1]}
  zle backward-delete-word
  if [[ -n "$prefix" && -n "${__FZF_COMMANDS[(i)${prefix}]}" ]]; then 
    zle "__${__FZF_COMMANDS[${prefix}]}"
  fi
  zle redisplay
}
zle -N __fzf-aweken

bindkey '^r' __fzf-history
bindkey '^ ' __fzf-aweken

export ENHANCD_FILTER=$__FZF_CMD

enable-fzf-tab
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'fzf-preview-check $realpath'
zstyle ':fzf-tab:complete:nvim:*' fzf-preview 'fzf-preview-check $realpath'
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
	'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
	'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
	'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	fzf-preview 'echo ${(P)word}'
zstyle ':fzf-tab:*' fzf-command $__FZF_CMD
zstyle ':fzf-tab:*' fzf-min-height 15
