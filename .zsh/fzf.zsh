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
