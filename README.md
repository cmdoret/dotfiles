# dotfiles

This repository contains my configuration files for most programs.

I manage those files using GNU stow.
The paths of my config files follow the [XDG base directory specification](https://wiki.archlinux.org/index.php/XDG_Base_Directory) to avoid cluttering the home directory.

## Installation

Clone the repository into `~/dotfiles` (or any custom dir) and use stow to automatically symlink the subfolder to `~/`

```sh
git clone --recurse-submodules https://github.com/cmdoret/dotfiles.git $HOME/dotfiles
cd $HOME/dotfiles && stow .
```

Proper display of nvim status bar characters and starship prompt indicators will require a nerd-patched font. This can be installed from: https://github.com/ryanoasis/nerd-fonts

## neovim

The NvChad distribution is packaged as a submodule, and a custom configuration is included in `.config/nvchad/custom`. To enable it, symlink it into the submodule:
```sh
ln -s $HOME/.config/nvchad/custom $HOME/.config/nvim/lua
```
