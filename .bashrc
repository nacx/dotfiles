CWD=$(dirname ${BASH_SOURCE[0]})

hash kubectl 2>/dev/null
HAS_K8S=$?

if [[ ${HAS_K8S} -eq 0 ]]; then
    BREW_PREFIX=$(brew --prefix)

    # Kubernetes
    KC=(~/.kube/config*)
    IFS=: eval 'export KUBECONFIG=${KC[*]}'
    KUBE_PS1=${BREW_PREFIX}/share/kube-ps1.sh
    if [[ -r ${KUBE_PS1} ]]; then
        source ${KUBE_PS1}
        kubeoff
    fi

    source <(kubectl completion bash)
    if [[ $(type -t compopt) = "builtin" ]]; then
        complete -o default -F __start_kubectl k
    else
        complete -o default -o nospace -F __start_kubectl k
    fi
    if [ -f ${BREW_PREFIX}/etc/bash_completion ]; then
        . ${BREW_PREFIX}/etc/bash_completion
    fi
fi

# Polyglot prompt (needs to go after kube-ps1 is loaded)
POLYGLOT=${CWD}/addons/polyglot/polyglot.sh
if [[ -f ${POLYGLOT} ]]; then
    source ${POLYGLOT}
    bind 'set show-mode-in-prompt off'

    if [[ ${HAS_K8S} -eq 0 ]]; then
        POLYGLOT_KUBE=${CWD}/addons/polyglot-kube-ps1/polyglot-kube-ps1.sh
        [[ -f ${POLYGLOT_KUBE} ]] && source ${POLYGLOT_KUBE}
    fi
fi

export KUBECTX_IGNORE_FZF=true
export KUBE_PS1_SYMBOL_ENABLE=true
export KUBE_PS1_CTX_COLOR=yellow
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Git completion
source ${CWD}/.git-completion.sh

# Environment variables
export EDITOR=vi
export GPG_TTY=$(tty)

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
alias kshell='kubectl run tmp-shell --rm -i --tty --image nicolaka/netshoot -- /bin/bash'
function kctxd() {
    kubectl config delete-context ${1}
    kubectl config delete-user ${1}
    kubectl config delete-cluster ${1}
}


alias tf='terraform'

function gitgomod() {
    TZ=UTC git --no-pager show --quiet --abbrev=12 --date='format-local:%Y%m%d%H%M%S' --format="%cd-%h"
}

