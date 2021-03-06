# ------------------------------------------------------ #
#  Prompt and Colours
# ------------------------------------------------------ #

function set_prompt {
    # Colours
    local BLACK="\[\033[0;30m\]"
    local BLACKBOLD="\[\033[1;30m\]"
    local RED="\[\033[0;31m\]"
    local REDBOLD="\[\033[1;31m\]"
    local GREEN="\[\033[0;32m\]"
    local GREENBOLD="\[\033[1;32m\]"
    local YELLOW="\[\033[0;33m\]"
    local YELLOWBOLD="\[\033[1;33m\]"
    local BLUE="\[\033[0;34m\]"
    local BLUEBOLD="\[\033[1;34m\]"
    local PURPLE="\[\033[0;35m\]"
    local PURPLEBOLD="\[\033[1;35m\]"
    local CYAN="\[\033[0;36m\]"
    local CYANBOLD="\[\033[1;36m\]"
    local WHITE="\[\033[0;37m\]"
    local WHITEBOLD="\[\033[1;37m\]"
    local RESET="\[\033[00m\]"

    # Special Variables
    local USER="\u" # the current username
    local HOST="\h" # the hostname up to the first '.'
    local HOST_FULL="\H" # the hostname
    local TIME_HHMMSS="\t" # time HH:MM:SS
    local DATE_WMD="\d"
    local BELL="\a" # terminal bell
    local BASHVER="\V" # bash version + patch level
    local WD="\w" # working directory
    local BWD="\W" # base name of working directory
    local NEWLINE="\n" # newline, should you forget
    local ROOTINDICATOR="\$"
    local TERMDEV="\l"

	if [[ $EUID -ne 0 ]]; then
        USER_COLOUR=${GREEN}
    else
        USER_COLOUR=${RED}
    fi

	export PS1="${BLUE}[${USER_COLOR}\u${WHITE}${BLUE}@${WHITE}\h${BLUE}]${PURPLE} \w\n${WHITE}\$\[$(tput sgr0)\] "
}
set_prompt

# ------------------------------------------------------ #
#  Aliases
# ------------------------------------------------------ #

alias ..='cd ../'
alias ls='ls --color'
alias ll='ls -la'
alias root='su -l root'
alias destroy='shred -n 10 -u -v -z'

