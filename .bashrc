# .bashrc


[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

source ~/.git-prompt.sh

#PS1 for root and users
if [[ ${EUID} == 0 ]] ; then
    export PS1='┌─\D{[%H:%M]}\[\033[01;31m\] \u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\[\033[01;033m\]$(__git_ps1)\[\033[00m\]\n└─╼ '
else
    export PS1='┌─\D{[%H:%M]}\[\033[01;32m\] \u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\[\033[01;033m\]$(__git_ps1)\[\033[00m\]\n└─╼ '
fi

# User specific aliases and functions
export PS1='\D{[%T]} \[\033[01;32m\] \u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;033m\]$(__git_ps1)\[\033[00m\] $'


# User defined aliases and functions
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# Genome cat :D
catg() { 
    cat $1 \
    | grep -v ">" \
    | GREP_COLOR="01;34" egrep -i --color=always "C" \
    | GREP_COLOR="01;32" egrep -i --color=always "A" \
    | GREP_COLOR="01;31" egrep -i --color=always "T" \
    | GREP_COLOR="01;33" egrep -i --color=always "G" 
}

# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Colors for ls
alias ll='ls -l --color=auto'
eval `dircolors -b`

# Colors for grep
export GREP_COLOR="1;32"
alias grep='grep --color=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

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

# Add anaconda to path and set default environment
export PATH="$PATH:/opt/anaconda/bin"
source activate py36
