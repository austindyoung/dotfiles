# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White
BoldYellow='\e[1;33m'   # Yellow


function current_directory() {
    pwd | sed "s:$HOME:~:"
}


function git_prompt_info() {
    if test -z $(git branch-or-sha);
    then
        echo ""
    else
        echo " $(separator "on") $(git branch-or-sha)$(git_status_character)"
    fi
}

function git_status_character() {
    if git dirty;
    then
        print_with_color "✘" "$Red"
    else
        print_with_color "✔" "$Green"
    fi
}

function sandbox_prompt() {
    if [ ! -z "$(sandbox_prompt_info)" ];
    then
        echo " $(separator "with") $(colored_sandbox_string)%{$reset_color%}"
    fi
}

function command_line_character() {
    if ! test -z $(git branch-or-sha);
    then 
        echo "±"
    else
        echo "○"
    fi
}

function prompt_basic_colors() {
    export USERNAME_COLOR="$Green"
    export SEPARATOR_COLOR="$Black"
    export HOSTNAME_COLOR="$Blue"
    export CURRENT_DIRECTORY_COLOR="$BoldYellow"
}

function print_with_color() {
    echo "$2$1\e[0m"
}

function separator() {
    print_with_color "$1" "$SEPARATOR_COLOR"
}

prompt_basic_colors
function set_bash_prompt() {
    PS1="╭─$(print_with_color "$(whoami)" "$USERNAME_COLOR") $(separator "at") $(print_with_color "`hostname -s`" "$HOSTNAME_COLOR") $(separator "in") $(print_with_color "`current_directory`" "$CURRENT_DIRECTORY_COLOR")$(git_prompt_info)$(sandbox_prompt)
╰─$(command_line_character) "
}

export PROMPT_COMMAND=set_bash_prompt

PS2='(%_) '
