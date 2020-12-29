# Navigation
alias ls="exa --long --header --git --group"
alias cat="bat --theme=GitHub"
alias tree="exa --tree"
alias la="ls -lhA"

# History
HISTSIZE=50000
HISTFILESIZE=50000
HISTCONTROL=ignoreboth
HISTIGNORE="ls:ll:cd:pwd:bg:fg:history"


if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
    # History
    shopt -s histappend
    # append and reload the history after each command
    PROMPT_COMMAND="history -a; history -n"

    for filename in ${HOME}/.ssh/*.pub; do
        keyname="$(basename ${filename} .pub)"
        eval $(keychain --nogui --eval --quiet ${keyname})
    done

    bind -x '"\C-r"':reset
fi

# Applications
alias tmux="tmux -2"
alias grep="grep --color=auto"

# Fix gpg signing
# https://github.com/keybase/keybase-issues/issues/2798
export GPG_TTY=$(tty)

# Golang
export PATH=$PATH:/usr/local/go/bin:${HOME}/go/bin

export TERM="xterm-256color"
export EDITOR=$(which vim)

# Adding applications to path
if [[ -d ${HOME}/bin ]];
then
    export PATH=$PATH:${HOME}/bin
fi

# Add a local un-tracked bash-rc if present
if [[ -f ${HOME}/.bashrc_local ]];
then
    source ${HOME}/.bashrc_local
fi

# Git
_git_safedel() {
    if [[ "${COMP_LINE}" =~ ^git\ safedel.*$ ]]; then
        __gitcomp_nl "$(__git_heads)"
    else
        __git_main
    fi
}
_git_top() {
    if [[ "${COMP_LINE}" =~ ^git\ top.*$ ]]; then
        __gitcomp_nl "$(__git_heads)"
    else
        __git_main
    fi
}

function up() {
    num=1
    if [ $# -gt 0 ]; then
        num=$1
    fi

    cd $(printf '../%.0s' $(seq 1 $num))
}

# Add color shortcuts
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  c_reset=`tput sgr0`
  c_user=`tput setaf 2; tput bold`
  c_path=`tput setaf 4; tput bold`
  c_git_clean=`tput setaf 2`
  c_git_dirty=`tput setaf 1`
else
  c_reset=
  c_user=
  c_path=
  c_git_cleanclean=
  c_git_dirty=
fi

git_prompt () {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        return 0
    fi

    git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')

    if git diff --quiet 2>/dev/null >&2; then
        git_color="${c_git_clean}"
    else
        git_color=${c_git_cleanit_dirty}
    fi

    echo " -- $git_color$git_branch${c_reset}"
}

kubectl_context() {
    if [ ! $(which kubectl) ]; then
        return 0
    fi

    context=$(kubectl config current-context 2>/dev/null)
    namespace=$(kubectl config view -o "jsonpath={.contexts[?(@.name==\"$context\")].context.namespace}")
    cluster=$(kubectl config view -o "jsonpath={.contexts[?(@.name==\"$context\")].context.cluster}")

    prod_color=`tput setaf 1; tput bold`
    dev_color=`tput setaf 4; tput bold`

    if [[ "$context" = *"hopcloud.extrahop.com"* ]]; then
        echo "-- ${prod_color}${cluster}:${namespace}${c_reset}"
    else
        echo "-- ${dev_color}${cluster}:${namespace}${c_reset}"
    fi
}

if [ "$BASH" != "" ]; then
    # Prompt
    PS1="\n╔ \w\$(git_prompt) \$(kubectl_context)\n╚ \h\$ "

    # enable bash completion in interactive shells
    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        . /etc/bash_completion
    fi
fi

