# Dotfiles

Current setup: WSL + [ArchWSL](https://github.com/yuk7/ArchWSL).

## Initialize keyring

```sh
sudo pacman-key --init
sudo pacman-key --populate
sudo pacman -Sy archlinux-keyring
sudo pacman -Su
```

## Pre-install
```sh
sudo pacman -Syu
sudo pacman -S openssh git make
```

## Clone dotfiles

```sh
git clone --bare git@github.com:innng/dotfiles.git $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
config config --local status.showUntrackedFiles no
```

## Config git

```sh
make config-git EMAIL="<email>" NAME="<name>"
```

## Useful links
- [Dotfiles management](https://www.atlassian.com/git/tutorials/dotfiles).
- [Initialize pacman keyring](https://wsldl-pg.github.io/ArchW-docs/How-to-Setup/#initialize-keyring).
- [Users and groups](https://wiki.archlinux.org/title/Users_and_groups).
- [Generate a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=linux).
