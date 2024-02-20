# This is my zsh configuration. It uses a few hand picked scripts from 
# oh-my-zsh without depending on the whole thing. For the best experience,
# the following CLI utilities should be installed, but they are not necessary:
# exa, bat, fd, fzf, pydf

# Uncomment next line (and last line 'zprof') to profile startup time
#zmodload zsh/zprof

plugins=(
  catimg
  vi-mode
)


# Load all stock functions (from $fpath files) called below.
fpath+=$XDG_CONFIG_HOME/zsh/zfunc
autoload -Uz compinit promptinit
compinit
promptinit

# User configuration
unsetopt AUTO_CD
export LANG=en_US.UTF-8
# Better killall completition
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

# vim as default editor
export EDITOR='vim'
# Colors for man
export LESS_TERMCAP_mb=$'\e[1;34m'
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;30m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'
# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# 
# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
#
# Configure history settings

export HISTFILE=~/.config/zsh/.histfile
export HISTSIZE=1000000 # Num items in local hist list
export SAVEHIST=1000000 # Max num items in hist file

setopt HIST_IGNORE_ALL_DUPS # Don't put duplicates in history list
setopt HIST_SAVE_NO_DUPS # Don't savec duplicates in history file
setopt HIST_REDUCE_BLANKS # Remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME # Append to history file immediatly upon execution
setopt EXTENDED_HISTORY # Record command start time

# Set up environment variables 
if [ -f ~/.config/env ]; then
	source ~/.config/env
fi

# Source plugins, aliases, libs
if [ -f ~/.config/aliases ]; then
	source ~/.config/aliases
fi

for lib in ~/.config/zsh/omz_libs/*.zsh; do
	source $lib
done

for plugin ($plugins); do
    if [ -f ~/.config/zsh/plugins/$plugin/$plugin.plugin.zsh ]; then
        source ~/.config/zsh/plugins/$plugin/$plugin.plugin.zsh
    fi
done


if [ -f ~/.config/conda/conda_init.sh ]; then
    source ~/.config/conda/conda_init.sh
fi

# Push 'v' in command mode to enter a vim buffer and edit command
bindkey -M vicmd v edit-command-line

# Source fzf keybindings to have access to fuzzy ALT+C,CTRL+R and CTRL+T
# Note: Looping on possible file locations (distro-dependent) rather than
# using regex gives better performance
for fzf_dir in fzf doc/fzf doc/fzf/examples fzf/examples; do
    fzf_dir="/usr/share/$fzf_dir"
    if [ -d $fzf_dir ]; then
        for fzf_file in $(find $fzf_dir -regex '.*\(key-bindings\|completion\).zsh' 2>/dev/null); do
            . $fzf_file
        done
    fi
done


# Use starship prompt
type starship >/dev/null 2>&1 && eval "$(starship init zsh)"
# Setup zoxide
type zoxide >/dev/null 2>&1 && eval "$(zoxide init --cmd cd zsh)"

#zprof

export KUBECONFIG="$HOME/.kube/config-sdscuser"
