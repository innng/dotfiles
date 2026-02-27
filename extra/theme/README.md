# Catppuccin Mocha Theme Configuration

## Color Palette

- **Background**: #1E1E2E
- **Surface**: #181825  
- **Overlay**: #313244
- **Text**: #CDD6F4
- **Subtext**: #A6ADC8
- **Muted**: #6C7086
- **Accent**: #CBA6F7 (Mauve)
- **Blue**: #89B4FA
- **Green**: #A6E3A1
- **Yellow**: #F9E2AF
- **Red**: #F38BA8
- **Teal**: #94E2D5
- **Peach**: #FAB387
- **Maroon**: #EBA0AC
- **Rosewater**: #F5E0DC

## Available Themes

### Waybar
- `waybar/colors.css` - Color variables
- `waybar/waybar.css` - Waybar styling

### Hyprland
- `hyprland.conf` - Border colors
- `hyprlock.conf` - Lock screen colors

### Applications
- `kitty.conf` - Terminal theme
- `discord/discord.css` - Discord theme (BetterDiscord)
- `spotify/spotify.css` - Spotify theme (Spicetify)
- `obsidian/obsidian.css` - Obsidian theme

## Installation Notes

### Discord
Install BetterDiscord, then enable the CSS in Settings > Themes > Open Theme Folder and add the discord.css file.

### Spotify
Install Spicetify, then run:
```bash
spicetify config current_theme CatppuccinMocha
spicetify apply
```

### Obsidian
Copy obsidian.css to your vault's `.obsidian/snippets/` folder and enable it in Settings > Appearance > CSS Snippets.

### GTK
Copy `gtk-3.0/settings.ini` to `~/.config/gtk-3.0/`
