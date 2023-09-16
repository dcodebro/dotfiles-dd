#!/usr/bin/bash
#########################
# \_   _\|_   _|| |_| | #
#   | |    \ |  | X X | #
#   | ||\__/ |  |X _ X| #
#   |_| \___/   / | | \ #
#########################
# ~/.bashrc       #
########################################
#  target:dd                           #
########################################
#                                      #
#                                      #
#                                      #
#                                      #
#                                      #
########################################
# If not running interactively, don't do anything
#[[ $- != *i* ]] && return

### CHANGELOG ###
### EXPORTS ###
  export TERM="xterm-256color"
  export HISTCONTROL=ignoredups:erasedups:ignorespace
  export EDITOR="micro"
  export MANPAGER="most"
  export PAGER="most"
  export PATH="/root/.local/bin:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.local/cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:$HOME/.config/bash/path"
  
  ### ENV ###
    export shrc="/boot/config/user/dotfiles/.bashrc"
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_CACHE_HOME="$HOME/.cache"

## SHOPT
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob # ** matches subdirectories * does not
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control

# bash autocomplete enhancements
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"
bind "TAB:menu-complete"
bind '"\e[Z":menu-complete-backward'
## FUNCTIONS
   # COUNTDOWN   
cdown () {
    N=$1
  while [[ $((--N)) >  0 ]]
    do
        echo "$N" &&  sleep 1
    done
}

# ARCHIVE EXTRACTION
  # usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
# navigation
up () {
  local d=""
  local limit="$1"
  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi
  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done
  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}
# ALIASES
alias top="htop"
alias ep="$EDITOR \"$shrc\" && source \"$shrc\" && cp \"$shrc\" \"$HOME/\""
alias nano="$EDITOR"
alias ed="$EDITOR"
alias ls='exa -la --color=always --group-directories-first'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias df='df -h'
alias du='du -sch'
alias dua='du -sch * | sort -h'
alias free='free -m'
alias rsync='rsync -avh --info=progress2'
alias rsync-np='rsync -vhrlptgoD --info=progress2'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'
alias town='PUID=$UID;PGID=$(id -g);sudo chown -R $PUID:$PGID'
alias ip="ip -4 addr show eno2 |\grep inet | awk '{ print $2 }' "
# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'
# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status'  # 'status' is protected name so using 'stat' instead
alias tag='git tag'
alias newtag='git tag -a'
# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"
### STARSHIP ###
eval "$(starship init bash)"
. "/home/tjh/.local/cargo/env"
