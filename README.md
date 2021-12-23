# dotfiles

This repository contains my configuration files for many programs.

I manage those files using a git bare repository (tutorial [here](https://www.atlassian.com/git/tutorials/dotfiles)).
The paths of my config files follow the [XDG base directory specification](https://wiki.archlinux.org/index.php/XDG_Base_Directory) to avoid cluttering the home directory.

## Installation

The repository must be cloned as a "bare" repository into your home directory by running the following commands in your home directory:

```sh
echo ".dotfiles" >> .gitignore
git clone --bare https://github.com/cmdoret/dotfiles.git $HOME/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
config checkout
config config --local status.showUntrackedFiles no
```

A config `config` alias is defined in `.config/aliases` to easily manage the dotfiles. This allows to commit the changes with:

```sh
config add <modified-file>
config commit <modified-file>
```

Proper display of vim-airline characters and starship prompt indicators will require a nerd-patched font. This can be installed from: https://github.com/ryanoasis/nerd-fonts
