autoload -Uz compinit && compinit
fpath=(${ASDF_DIR}/completions $fpath)

zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''

zstyle ':completion:*:default' menu select=1

zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

enable-fzf-tab
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
