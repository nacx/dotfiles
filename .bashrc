# Git configuration
if [ -f ~/.git-completion.sh ]; then
    source ~/.git-completion.sh
fi

# Environment variables
export PS1='\u@\h:\w $(__git_ps1 "(%s) ")\$ '

# Ruby configuration
eval "$(rbenv init -)"

# Aliases
alias ls='ls -G'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias ..='cd ..'
alias p='ps aux | grep -i'

alias mvn='mvn -fae'
alias mvnci='mvn clean install'

alias git-delete='for f in `git ls-files -d`; do git rm $f; done'

# Open Vim with tmux
function vim_tmux() { tmux new -d "vim $*" \; attach; }
alias vim='vim_tmux'

# Set a tmux friendly terminal terminal
if [[ "$TERM" == "xterm" ]]; then
    TERM=xterm-256color
fi
