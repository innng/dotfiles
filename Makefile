.ONESHELL:
.PHONY:

initialize-keyring:
	sudo pacman-key --init
	sudo pacman-key --populate
	sudo pacman -Sy archlinux-keyring
	sudo pacman -Su

base-install:
	sudo pacman -S git base-devel zsh openssh tk

setup-zsh:
	sudo pacman -S zsh --noconfirm
	chsh -s $$(which zsh)

setup-asdf:
	cd /tmp
	git clone https://aur.archlinux.org/asdf-vm.git
	cd asdf-vm 
	makepkg -si
	cd $$HOME
	mkdir -p "${ASDF_DATA_DIR:-$HOME/.asdf}/completions"
	asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"

setup-asdf-plugins:
	asdf plugin add python; asdf install python 3.13.3; asdf set -u python 3.13.3
	asdf plugin add starship; asdf install starship latest; asdf set -u starship latest
	asdf plugin add yay; asdf install yay latest; asdf set -u yay latest
	
setup-antidote: setup-asdf-plugins
	yay -S zsh-antidote

install-extras: setup-antidote
	yay -S fzf thefuck zsh-autosuggestions-git zsh-syntax-highlighting-git

config-git:
	git config --global user.email "$(EMAIL)" 
	git config --global user.name "$(NAME)"
	/usr/bin/git --git-dir=$$HOME/.cfg/ --work-tree=$$HOME update-index --assume-unchanged .gitconfig