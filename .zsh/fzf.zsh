# DEFAULT_OPTS
export FZF_COMPLETION_TRIGGER=','
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

() {
  local -A color_map=(
    [fg]='-1'
    [bg]='-1'
    [hl]='33'
    [fg+]='250'
    [bg+]='235'
    [hl+]='33'
    [info]='37'
    [prompt]='37'
    [pointer]='230'
    [marker]='230'
    [spinner]='37'
  )
  for x in "${(k)color_map[@]}"; do
    fzf_color_opts+=("${x}:${color_map[${x}]}") 
  done
  fzf_default_opts+=( '--color="'"${(j.,.)fzf_color_opts}"'"' )
}

# FZF FUNCTIONS
fbr() {
  local branches branch
  branches=$(git branch -vv) && 
    branch=$(echo "$branches" fzf +m) &&
    git checkout $(echo $"branch" | awk '{print $1}' | sed "s/.* //")
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

# dedit() {
#   local dot
#   dot=$(fd --full-path -t f -H "$HOME/.dotfiles" | sed 's/ /\\ /g' | fzf --multi --preview="fzf-preview-file {}" ) &&
#     nvim "$dot"
# }

fzf-src() {
  local src=$(ghq list --full-path | fzf)
  if [ -n "$src" ]; then
    BUFFER="cd $src"
    zle accept-line
  fi
  zle -R -c
}
zle -N fzf-src
bindkey '^]' fzf-src

export ENHANCD_FILTER="fzf"
