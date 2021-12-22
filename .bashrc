# .bashrc
colors(){
    local fgc bgc vals seq0

    printf "Color escapes are %s\n" '\e[${value};...;${value}m'
    printf "Values 30..37 are \e[33mforeground colors\e[m\n"
    printf "Values 40..47 are \e[43mbackground colors\e[m\n"
    printf "Value 1 gives a \e[1mbold-faced look\e[m\n"

    # foreground colors
    for fgc in {30..37}; do
        # background colors
        for bgc in {40..47}; do
            fgc=${fgc#37} #white
            bgc=${bgc#40} #black

            vals="${fgc:+$fgc;}${bgc}"
            vals=${vals%%;}

            seq0="${vals:+\e[${vals}m}"
            printf " %-9s" "${seq0:-(default)}"
            printf " ${seq0}TEXT\e[m"
            printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
        done
        echo;echo
    done
}

[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f ~/.config/aliases ]; then
	source ~/.config/aliases
fi

# Load environment variables
if [ -f ~/.config/env ]; then
    source ~/.config/env
fi

#PS1 for root and users
if [[ ${EUID} == 0 ]] ; then
    export PS1='┌─\D{[%H:%M]}\[\033[01;36m\] \u@\h\[\033[00m\]:\[\033[01;25m\]\W\[\033[00m\]\[\033[01;033m\]$(__git_ps1)\[\033[00m\]\n└─╼ '
else

    export PS1='┌─\D{[%H:%M]}\[\033[01;31m\] \u@\h\[\033[00m\]:\[\033[01;25m\]\W\[\033[00m\]\[\033[01;033m\]$(__git_ps1)\[\033[00m\]\n└─╼ '
fi


eval `dircolors -b`

# Colors for grep
export GREP_COLOR="1;32"
# Colors for man
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'


if [ -f ~/.config/conda/conda_init.sh ]; then
    source ~/.config/conda/conda_init.sh
fi
