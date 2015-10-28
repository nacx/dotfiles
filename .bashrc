# Git configuration
if [ -f ~/.git-completion.sh ]; then
    source ~/.git-completion.sh
fi

# Environment variables
export PS1='\u@\h:\w $(__git_ps1 "(%s) ")\$ '

# Ruby configuration
eval "$(rbenv init -)"

# Aliases
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias targ='tar xvzf'
alias tarb='tar xvjf'

alias ..='cd ..'
alias p='ps aux | grep -i'

alias mvn='mvn -fae'
alias mvnci='mvn clean install'
alias mvnts='mvn clean install -Dtest.suite=single -Dit.suite=none'
alias mvnis='mvn clean install -Dtest.suite=none -Dit.suite=single'
alias mvnta='mvn clean install -Dtest.suite=all -Dit.suite=all'
alias mvntn='mvn clean install -Dtest.suite=none -Dit.suite=none'

alias git-delete='for f in `git ls-files -d`; do git rm $f; done'

function tolatest() {
    git fetch origin
    git checkout ${1}
    git pull origin ${1}
    git submodule update --init
    git submodule foreach git fetch origin
    git submodule foreach git checkout ${1}
    git submodule foreach git pull origin ${1}
    git status
}

# Open Vim with tmux
function vim_tmux() { tmux new -d "vim $*" \; attach; }
alias vim='vim_tmux'

# Set a tmux friendly terminal terminal
if [[ "$TERM" == "xterm" ]]; then
    TERM=xterm-256color
fi
