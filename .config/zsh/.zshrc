
plugins=(
  catimg
  vi-mode
)


# Load all stock functions (from $fpath files) called below.
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

# Use starship prompt
eval "$(starship init zsh)"
