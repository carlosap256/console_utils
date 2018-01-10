
#alias gitgraph='git log --graph --oneline --decorate --all'
alias gg='git log --all --graph --pretty=format:"%C(auto)%h%C(auto)%d %s %C(magenta bold)[%aN] %C(white bold)(%ar)"'
alias gts='git status -s -b'


# tail -f file | grep --line-buffered my_pattern

function grep_tail () { tail -f $1 | grep --line-buffered $2; }
alias gtail='grep_tail' 
