function command_not_found_handler {
    local bright='\e[0;1m' red='\e[1;31m' reset='\e[0m'
    printf "${bright}zsh${reset}: ${red}command not found${reset}: ${bright}'%s'${reset}\n" "$1"
    return 127
}

function no_such_file_or_directory_handler {
    local red='\e[1;31m' reset='\e[0m'
    printf "${red}zsh: no such file or directory: %s${reset}\n" "$1"
    return 127
}