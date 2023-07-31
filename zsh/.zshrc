#
#                        $$\       
#                        $$ |      
#    $$$$$$$$\  $$$$$$$\ $$$$$$$\  
#    \____$$  |$$  _____|$$  __$$\ 
#      $$$$ _/ \$$$$$$\  $$ |  $$ |
#     $$  _/    \____$$\ $$ |  $$ |
#    $$$$$$$$\ $$$$$$$  |$$ |  $$ |
#    \________|\_______/ \__|  \__|
#                              

# ======================================================= #    
# History                                                 #    
# ======================================================= #
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# ======================================================= #    
# Directory Listing Colours                               #    
# ======================================================= #
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=30;42:st=37;44:ex=01;32:';
export LS_COLORS

# ======================================================= #    
# Aliases and Useful Commands                             #
# ======================================================= #
alias pacman="pacman --color auto"
alias yay="yay --color auto"
alias sd="sudo shutdown now"
alias gc="git clone"
alias gp="git pull"
alias ls="ls --color"
alias ll="ls -lah"
alias gdb="gdb -q"
alias reload-polybar="pkill -USR1 polybar"
alias http="python2 -m SimpleHTTPServer"
alias ipf="sudo ip addr flush"
alias v="nvim"
alias vim="nvim"
alias ..="cd ../"
alias change-java="archlinux-java"

set_debian_aliases () {
	alias i="sudo apt-get install"
    alias s="apt-cache search --names-only"
    alias upgrade="sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade && sudo apt-get autoremove"
    alias update="upgrade"
    alias u="upgrade"
}

set_arch_aliases() {
    alias s="yay -Ss"
	alias i="yay -S"
	alias upgrade="yay -Syu"
    alias update="upgrade"
    alias u="upgrade"
}

if [ -e "/etc/lsb-release" ]; then
	if grep -qE "Kali|Debian" /etc/lsb-release; then set_debian_aliases; fi
    if grep -qE "Arch|Anarchy" /etc/lsb-release; then set_arch_aliases; fi
fi

if [ -e "/etc/os-release" ]; then
	if grep -qE "Kali|Debian" /etc/os-release; then set_debian_aliases; fi
    if grep -qE "Arch|Anarchy" /etc/os-release; then set_arch_aliases; fi
fi

ifdu () {
    sudo ifdown $1
    sudo ifup $1
}

extract () {
if [ -f $1 ] ; then
  case $1 in
    *.tar.bz2)   tar xjf $1     ;;
    *.tar.gz)    tar xzf $1     ;;
    *.bz2)       bunzip2 $1     ;;
    *.rar)       unrar e $1     ;;
    *.gz)        gunzip $1      ;;
    *.tar)       tar xf $1      ;;
    *.tbz2)      tar xjf $1     ;;
    *.tgz)       tar xzf $1     ;;
    *.zip)       unzip $1       ;;
    *.Z)         uncompress $1  ;;
    *.7z)        7z x $1        ;;
    *)     echo "'$1' cannot be extracted via extract()" ;;
     esac
 else
     echo "'$1' is not a valid file"
 fi
}

# ======================================================= #    
# Keybindings                                             #    
# ======================================================= #
bindkey -v
typeset -g -A key
bindkey '\e[3~' delete-char
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[2~' overwrite-mode
bindkey '^?' backward-delete-char
bindkey '^[[1~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[4~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char 
bindkey '^R' history-incremental-search-backward

# ======================================================= #    
# Auto Completion                                         #
# ======================================================= #
zmodload zsh/complist 
autoload -Uz compinit
compinit
zstyle :compinstall filename '${HOME}/.zshrc'

#- buggy
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
#-/buggy

zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

#- complete pacman-color the same as pacman
compdef _pacman pacman-color=pacman

# ======================================================= #    
# Prompt                                                  #
# ======================================================= #
autoload -U colors zsh/terminfo
colors

setprompt() {
  # load some modules
  setopt prompt_subst

  # make some aliases for the colours: (coud use normal escap.seq's too)
  for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$fg[${(L)color}]%}'
  done
  PR_NO_COLOR="%{$terminfo[sgr0]%}"

  # Check the UID
  if [[ $UID -ge 1000 ]]; then # normal user
    eval PR_USER='${PR_MAGENTA}%n${PR_NO_COLOR}'
    eval PR_USER_OP='${PR_CYAN}\$${PR_NO_COLOR}'
  elif [[ $UID -eq 0 ]]; then # root
    eval PR_USER='${PR_RED}%n${PR_NO_COLOR}'
    eval PR_USER_OP='${PR_RED}\$${PR_NO_COLOR}'
  fi

  # Check if we are on SSH or not
  if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
    eval PR_HOST='${PR_YELLOW}%M${PR_NO_COLOR}' #SSH
  else
    eval PR_HOST='${PR_NO_COLOR}%M' # no SSH
  fi

  # set the prompt
  PS1=$'${PR_NO_COLOR}${PR_CYAN}${PR_WHITE}${PR_USER}${PR_CYAN}@${PR_HOST}${PR_CYAN}${PR_BLUE} %~${PR_CYAN}\n${PR_USER_OP} '
  PS2=$'%_>'
}
setprompt

autoload -Uz vcs_info

# ======================================================= #    
# Git Information                                         #
# ======================================================= #

# Commands to be executed, before zsh execs the requested cmd
precmd_vcs_info() { 
    vcs_info
}
precmd_functions+=( precmd_vcs_info )
# This enables prompt substitution. 
setopt prompt_subst

zstyle ':vcs_info:*' check-for-changes false
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
# Set the content of the prompt area that appears on the right hand side
RPROMPT='${vcs_info_msg_0_}'
# Sets the display format for Git repositories
#zstyle ':vcs_info:git:*' formats "%c %u %i [${PR_MAGENTA}%b${PR_NO_COLOR}]"
zstyle ':vcs_info:git:*' formats "[${PR_MAGENTA}%b${PR_NO_COLOR}]"

# ======================================================= #    
# Plugins                                                 #
# ======================================================= #
ZSHDIR1="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
ZSHDIR2="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [ -e "$ZSHDIR1" ]; then
    source $ZSHDIR1
fi
if [ -e "$ZSHDIR2" ]; then
    source $ZSHDIR2
fi

# ======================================================= #    
# Environment Variables                                   #
# ======================================================= #
export EDITOR=vim
export VISUAL=vim
export TERM=xterm
export PATH=$PATH:/usr/local/bin

source ~/.local-aliases
