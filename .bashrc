CWD=$(dirname ${BASH_SOURCE[0]})

# Kubernetes
export KUBECONFIG=$(find ~/.kube -name 'config-*' | tr '\n' ':')
KUBE_PS1=$(brew list -1 kube-ps1 | grep '.sh$')
if [[ -f ${KUBE_PS1} ]]; then
    source ${KUBE_PS1}
    kubeoff
fi

# Polyglot prompt (needs to go after kube-ps1 is loaded)
POLYGLOT=${CWD}/addons/polyglot/polyglot.sh
if [[ -f ${POLYGLOT} ]]; then
    source ${POLYGLOT}
    bind 'set show-mode-in-prompt off'

    POLYGLOT_KUBE=${CWD}/addons/polyglot-kube-ps1/polyglot-kube-ps1.sh
    [[ -f ${POLYGLOT_KUBE} ]] && source ${POLYGLOT_KUBE}
fi

export KUBE_PS1_SYMBOL_ENABLE=true
export KUBE_PS1_CTX_COLOR=yellow

# Git completion
source ${CWD}/.git-completion.sh

# Environment variables
export EDITOR=vim

# Aliases
alias ls='ls -G'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias targ='tar xvzf'
alias tarb='tar xvjf'

alias sshi='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias scpi='scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

alias ..='cd ..'
alias p='ps aux | grep -i'

alias mvn='mvn -fae'
alias mvncp='mvn clean package'
alias mvnci='mvn clean install'

alias k='kubectl'
alias ki='kubectl -n istio-system'
alias kctx='kubectx'
alias kns='kubens'
alias mixl='kubectl -n istio-system logs $(kubectl -n istio-system get pods -lapp=policy -o jsonpath="{.items[0].metadata.name}") -c mixer -f'

alias tf='terraform'

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

function git-withbr() {
    # To allow proper input variable substitution we need to construct the string command this way.
    # We want the input variable to be substituted *before* running the command, but all the git and
    # other commands to be not substituted and run in each submodule
    CMD='if [[ $(git branch --list '
    CMD+=${1}
    CMD+=') =~ '
    CMD+=${1}
    CMD+=' ]]; then echo $(basename $(pwd)); fi '
    git submodule --quiet foreach "${CMD}"
}

# Open Vim with tmux
function vim_tmux() { tmux new -d "vim $*" \; attach; }
alias vim='vim_tmux'

# Set a tmux friendly terminal terminal
if [[ "$TERM" == "xterm" ]]; then
    TERM=xterm-256color
fi

# Easily change to Go package source directories (e.g. gocd .../policy)
function gocd() { cd `go list -f '{{.Dir}}' $1`; }

