# Dotfiles

## Clone dotfiles

```sh
git clone --bare git@github.com:innng/dotfiles.git $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
config config --local status.showUntrackedFiles no
```

## References
- [Dotfiles management](https://www.atlassian.com/git/tutorials/dotfiles).
- [Initialize Pacman Keyring](https://wsldl-pg.github.io/ArchW-docs/How-to-Setup/#initialize-keyring).
