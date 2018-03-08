
#alias gitgraph='git log --graph --oneline --decorate --all'
alias gg='git log --all --graph --pretty=format:"%C(auto)%h%C(auto)%d %s %C(magenta bold)[%aN] %C(white bold)(%ar)"'
alias gts='git status -s -b'

function delete_branch () { echo -e "\nDeleting Remote branch";
                            echo "git push origin :$1"
                            git push origin :$1
                            echo -e "\nDeleting Local branch"
                            echo "git branch -d $1"
                            git branch -d $1
                            }
alias gdb='delete_branch' 

# tail -f file | grep --line-buffered my_pattern

function grep_tail () { tail -f $1 | grep --line-buffered $2; }
alias gtail='grep_tail' 
