
# Navigation
if [[ ! "$OSTYPE" == darwin* ]];
then
    alias ls="ls --color=auto"
fi
alias c="clear"
alias ..="cd ..;"
alias la="ls -lhA"
alias rmr="rm -r"

# Disable the lockup of doom from ctrl+s
#stty -ixon

# History
HISTSIZE=50000
HISTFILESIZE=50000
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend

# Applications
alias tmux="tmux -2"
alias grep="grep --color=auto"
alias extract="tar xvf"
alias df="df -h"

# Golang
export PATH=$PATH:/usr/local/go/bin:${HOME}/go/bin

# VPN
alias connect="sudo openvpn --config $HOME/home.ovpn"

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export TERM="xterm-256color"
export EDITOR=$(which vim)


function sshhome() {
    sudo echo "logged in..."
    sudo openvpn --config $HOME/home.ovpn --route-nopull &
    sleep 4
    sudo ip route add 192.168.0.0/24 dev tun0
}

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

# (f)ind by (n)ame
# usage: fn foo
# to find all files containing 'foo' in the name
function fn() {
	if [ $# -eq 2 ]; then
		sudo find $1 -name $2
	elif [ $# -eq 1 ]; then
		find `pwd` -name $1
    else
        echo "(f)ind by (n)ame"
        echo "usage: fn [name]"
        echo "Where name is the file name to search for"
	fi
}

# (f)ind by (b)ody
# usage: fb foo
# to find all files containing 'foo' in the body.
#
# usage: fb foo txt
# to find all files ending in '.txt' containing 'foo' in the body.
function fb() {
    if [ $# -eq 2 ]; then
        grep -r --include="*.$2" $1
    elif [ $# -eq 1 ]; then
        grep -r "$1"
    else
        echo "(f)ind by (b)ody"
        echo "usage: fb [query] [extension]"
        echo "Where query is the string to search for and extension is optional restriction on what files to search"
    fi
}

# wificonnect
# usage: wificonnect <ssid> <password>
# Connects the computer to the provided network
# Assumes the network interface is wlan0
function wificonnect() {
    if [ $# -ne 2]; then
        echo "wificonnect"
        echo "usage: wificonnect <ssid> <password>"
    else
        nmcli d wifi connect $1 password $2 iface wlan0
    fi
}

# Prompt Related Helpers

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
    context=$(kubectl config current-context 2>/dev/null)
    namespace=$(kubectl config view -o "jsonpath={.contexts[?(@.name==\"$context\")].context.namespace}")

    prod_color=`tput setaf 1; tput bold`
    dev_color=`tput setaf 4; tput bold`

    if [[ "$context" = *"hopcloud.extrahop.com"* ]]; then
        echo "${prod_color}${context}:${namespace}${c_reset}"
    else
        echo "${dev_color}${context}:${namespace}${c_reset}"
    fi
}

# Prompt
PS1="\n╔ \w -- \$(ls -1 | wc -l | sed 's: ::g') files\$(git_prompt) -- \$(kubectl_context)\n╚ \h\$ "

