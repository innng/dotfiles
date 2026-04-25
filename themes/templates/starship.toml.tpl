command_timeout = 3000
palette = "theme"

[palettes.theme]
foreground = "{{ foreground }}"
background = "{{ background }}"
accent = "{{ accent }}"
color0 = "{{ color0 }}"
color1 = "{{ color1 }}"
color2 = "{{ color2 }}"
color3 = "{{ color3 }}"
color4 = "{{ color4 }}"
color5 = "{{ color5 }}"
color6 = "{{ color6 }}"
color7 = "{{ color7 }}"
color8 = "{{ color8 }}"
color9 = "{{ color9 }}"
color10 = "{{ color10 }}"
color11 = "{{ color11 }}"
color12 = "{{ color12 }}"
color13 = "{{ color13 }}"
color14 = "{{ color14 }}"
color15 = "{{ color15 }}"

[character]
success_symbol = "[>](bold fg:color2)"
error_symbol = "[>](bold fg:color1)"
vimcmd_symbol = "[<](bold fg:accent)"

[directory]
style = "bold fg:foreground"
truncation_length = 3
truncate_to_repo = true
fish_style_pwd_dir_length = 1

[git_branch]
style = "bold fg:accent"

[git_status]
style = "bold fg:color1"

[cmd_duration]
min_time = 3000
style = "fg:color3"

[line_break]
disabled = false