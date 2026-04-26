# Some dots here and there

Hyprland setup heavily based on [HyDE](https://github.com/HyDE-Project/HyDE) and [Omarchy](https://github.com/basecamp/omarchy).

## Dependencies

### Projects
- Bootloader: [Catppuccin Grub](https://github.com/catppuccin/grub)
- Greeter: [Catppuccin SDDM](https://github.com/catppuccin/sddm)

### Packages
See `packages.lst` and `flatpak.lst`.

## Install

```sh
git clone git@github.com:innng/dotfiles.git ~/.dots
~/.dots/bin/dots-install
```

Reboot or log out after install, then apply a theme and font:

```sh
dots-theme-set <catppuccin|rose-pine> 
```

## Theme System

Themes live in `themes/<name>/` and define colors in `colors.toml`. Template files in `themes/templates/*.tpl` use `{{ variable }}`, `{{ variable_strip }}`, and `{{ variable_rgb }}` placeholders that get substituted from `colors.toml`.

Each theme can also provide static app-specific config files (like `kitty.conf`, `mako.ini`, `hyprland.conf`) that override template-generated versions.

### Themed Applications

| App | Template / Static | Reload Signal |
|-----|-------------------|---------------|
| Hyprland | Template + static | `hyprctl reload` |
| Hyprlock | Template + static | - |
| Kitty | Template + static | `SIGUSR1` |
| Waybar | Template | `SIGUSR2` |
| Mako | Template + static | `SIGHUP` |
| SwayOSD | Template + static | `SIGUSR1` |
| btop | Template + static | `SIGUSR2` (symlink) |
| GTK4 | Template | symlink |
| Rofi | Template | - |
| Starship | Template | env `STARSHIP_CONFIG` |
| Wlogout | Template | copy to `~/.config/wlogout/` |
| Obsidian | Template | - |
| OpenCode | Template | - |
| Spicetify | Static | `spicetify apply` |

### Manual Theme Setup (not templated)

Some applications require manual one-time setup using links or theme files:

#### Telegram Desktop
- Catppuccin Mocha: `t.me/addtheme/ctp_mocha`
- Rose Pine: `t.me/addtheme/Rose_Pine_TelegramDesktop`
- Rose Pine Moon: `t.me/addtheme/Rose_Pine_Moon_TelegramDesktop`

#### Firefox
- [Catppuccin Firefox](https://github.com/catppuccin/firefox) — requires [Firefox Color](https://addons.mozilla.org/en-GB/firefox/addon/firefox-color/) extension
- [Rose Pine Firefox](https://github.com/rose-pine/firefox) — requires Firefox Color extension

#### Discord (Vencord)
Theme CSS is stored in `themes/<name>/discord.css` and auto-symlinked to `~/.config/Vencord/themes/` by `dots-theme-set`.

#### Spotify (Spicetify)
Color schemes are stored in `themes/<name>/spotify.ini` and auto-configured by `dots-theme-set`. Requires `spicetify-cli` and `spicetify-themes` packages. Run `spicetify apply` manually after the first theme set or Spotify update.

## Font System

`dots-font-set <font-name>` changes the monospace font across all configured apps:
- Kitty, Waybar, Hyprland, Rofi, SwayOSD, Fontconfig

`dots-font-list` shows available monospace fonts.
