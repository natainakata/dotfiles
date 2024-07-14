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
function __fzf-cdrr() {
  # ~ ESCAPE
  local selected_dir=$(cdr -l | awk '{ print $2 }' | sed -e "s%~%${__HOME}%g" | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --preview="echo -e {} | ${__FZF_DIR_PREVIEW_CMD[*]}" --prompt="cdr → " --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    local BUFFER="cd ${selected_dir}"
  fi
  zle reset-prompt
}
zle -N fzf-cdrr __fzf-cdrr

function __fzf-git_switch() {
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
  zle reset-prompt
}
zle -N fzf-git_switch __fzf-git_switch

function __fzf-git_add() {
  local target_add=$(
    git status -s  |
      ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} -m \
      --prompt="git add → " \
      --header=$'Press Ctrl-A: --all' \
      --bind "ctrl-a:toggle-all" \
      --preview="echo {} | awk '{ print \$2 }' | xargs git diff --color | bat --style=numbers " \
      | awk '{ print $2 }'
  )
  if [ -n "$target_add" ]; then
    target_add=$(tr '\n' ' ' <<< "$target_add")
    local BUFFER="git add $target_add"
  fi
  zle reset-prompt
}
zle -N fzf-git_add __fzf-git_add

function __fzf-history() {
  local BUFFER=$(history -n -r 1 | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --prompt="cmd history → " --no-sort --query "$LBUFFER")
  zle reset-prompt
}
zle -N fzf-history __fzf-history

function __fzf-src() {
  local src=$(ghq list --full-path | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --preview="echo {} | ${__FZF_DIR_PREVIEW_CMD[*]}" --prompt="src → " --query "$LBUFFER")
  if [ -n "$src" ]; then
    BUFFER="cd $src"
  fi
  zle reset-prompt
}
zle -N fzf-src __fzf-src

function __fzf-edit() {
files=$(lsd --almost-all | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --preview="echo -e {} | awk '{ print substr(\$1, 2) }' | fzf-preview-check {}" --prompt="edit → " -m --query "$LBUFFER")
  if [ -n "$files" ]; then
    BUFFER="${EDITOR} ${files[@]}"
  fi
  zle reset-prompt
}
zle -N fzf-edit __fzf-edit

function __fzf-tmux() {
  if [ -n "$TMUX" ]; then
    local sessions=$(tmux list-sessions | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --prompt="sessions → " -m --query "$LBUFFER" | cut -d : -f 1)
    if [ -n "$sessions" ]; then
      tmux switch -t $sessions
    fi
  fi
}
zle -N fzf-tmux __fzf-tmux

function __fzf-snippets() {
  local snippets=$(cat $ZSHRC_DIR/config/zsh_snippet | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} | cut -d ':' -f2-)
  LBUFFER="${LBUFFER}${snippets}"
  zle reset-prompt;
}

zle -N fzf-snippets __fzf-snippets

bindkey -r "^ "
bindkey  "^r" fzf-history
bindkey  "^ ^s" fzf-src
bindkey  "^ ^b" fzf-git_switch
# bindkey -M emacs "" fzf-edit
bindkey  "^ ^t" fzf-tmux
bindkey  "^ ^a" fzf-git_add
bindkey  "^o" fzf-cdrr
bindkey  "^ ^l" fzf-snippets

