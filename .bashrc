# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

source ~/.git-prompt.sh

# User specific aliases and functions
export PS1='\D{[%T]} \[\033[01;32m\] \u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;033m\]$(__git_ps1)\[\033[00m\] $'


# Colors for ls
alias ll='ls -l --color=auto'
eval `dircolors -b`

# Colors for grep
export GREP_COLOR="1;32"
alias grep='grep --color=auto'

# Graphical display for network stats
alias ntop='speedometer -l -r enp3s0 -t enp3s0 -m $(( 1024 * 1024 * 3 / 2 ))'


# Colors for man
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

