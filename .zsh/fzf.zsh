# Sources：https://zenn.dev/yushin_hirano/articles/28e7ea8cd11bc1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# DEFAULT_OPTS
export FZF_COMPLETION_TRIGGER=','
if [[ -n ${TMUX-} ]]; then
  typeset -Tgx FZF_DEFAULT_OPTS fzf_default_opts " " 
  fzf_default_opts=(
    '--height=70%'
    '--reverse'
    '--inline-info'
    # '--prompt="→ "'
    '--margin=0,2'
    '--tiebreak=index'
    '--filepath-word'
  )
  export FZF_TMUX_OPTS="-p 80%"
  __FZF_CMD="fzf-tmux"
  __FZF_CMD_OPTS=(
      -p
      80%
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
    # '--prompt="→ "'
    '--margin=0,2'
    '--tiebreak=index'
    '--filepath-word'
  )
fi

export FZF_DEFAULT_COMMAND='fd --tye f --strip-cwd-prefix'

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
    --icon=never
    --color=always
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

# FZF FUNCTIONS

fzcdr() {
  local selected_dir=$(cdr -l | awk '{ print $2 }' | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --prompt="cdr →" --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    local BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N fzcdr

bindkey "^O" fzcdr

fbr() {
  local branch=$(git branch -vv | awk '{ print $2 }' | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --prompt="branch →" --query "$LBUFFER")
  git checkout $(echo ${branch} | awk '{ print $1 }' | sed "s/.* //")
}

fbrm() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) && 
    branch=$(echo "$branches" | 
    fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo $"branch" | awk '{print $1}' | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

fshow() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --bind=ctrl-s:toggle-sort \
    --bind "ctrl-m:execute: 
      (grep -o '[a-f0-9]\{7\}' | head -l |
      xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
      {}
  FZF-EOF" 
}

fcd() {
  local dir
  dir=$(fd -H -t d | fzf +m) &&
  cd "$dir"
}

fhistory() {
  local BUFFER=$(history -n -r 1 | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --prompt="cmd history → " --no-sort +m --query "$LBUFFER")
  local CURSOR=$#BUFFER
}

zle -N fhistory
bindkey '^r' fhistory


# dedit() {
#   local dot
#   dot=$(fd --full-path -t f -H "$HOME/.dotfiles" | sed 's/ /\\ /g' | fzf --multi --preview="fzf-preview-file {}" ) &&
#     nvim "$dot"
# }

fzf-src() {
  local src=$(ghq list --full-path | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --prompt="src →" +m --query "$LBUFFER")
  if [ -n "$src" ]; then
    BUFFER="cd $src"
    zle accept-line
  fi
  zle -R -c
}
zle -N fzf-src
bindkey '^ ' fzf-src

fsmug() {
  local templates="`ls $HOME/.config/smug | sed -e \"s/\\.yml//g\" | fzf --header=\"Templates\"`"
  if [ -n "$templates" ]; then
    smug start $templates
  fi
}

ftmux() {
  local sessions=$(tmux list-sessions | fzf)
  if [ -n "$sessions" ]; then
    tmux attach-session -t $sessions
  fi
}

export ENHANCD_FILTER="fzf"
