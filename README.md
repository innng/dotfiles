# Some dots here and there

Hyprland setup heavily based on [HyDE](https://github.com/HyDE-Project/HyDE) and [Omarchy](https://github.com/basecamp/omarchy).

## Dependecies

### Projects
- Bootloader: [Catppuccin Grub](https://github.com/catppuccin/grub)
- Greeter: [Catppuccin SDDM](https://github.com/catppuccin/sddm)

## Install steps

```sh
$ git clone git@github.com:innng/dotfiles.git ~/.dots
$ sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
$ yay -Syyuu
$ yay -S $(cat ~/.dots/packages.lst)
$ flatpak install $(cat ~/.dots/flatpak.lst)
$ mkdir -p ~/.local/share/applications
ln -s /var/lib/flatpak/exports/share/applications/*.desktop ~/.local/share/applications/ 
```
```
```
