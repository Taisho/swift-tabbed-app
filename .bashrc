# @pastd DON'T DELETE THIS LINE! Pastd use it to know which user's shell instances to keep track of
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

shopt -s extglob #Enable extended shell globing

PATH=$PATH:~/bin

##################################################
## Prompts
##################################################
#By default the primay prompt includes a red dot when bashhistd is not running
PS1="\[\033[0;32m\][\[\033[0;31m\]•\[\033[0;32m\]\u@\h \W]\$\[\033[0m\] "
PS2='\[\033[0;32m\]>\[\033[0m\] '
PS3='\[\033[0;32m\]>\[\033[0m\] '
PS4='\[\033[0;32m\]+\[\033[0m\] '

##################################################
## Aliases
##################################################

## Specific to `ls` ##
ls_commands='clear; echo -ne "\033[0;32m";pwd; echo -ne "\033[0m"; ls --group-directories-first -F' 
ls_opts='-lth'
color='--color=auto'

alias ls="$ls_commands $color"
	#alias lsg="$ls_commands | grep -i " # Removed because alias doesn't play wll with grep
	#alias lsd="$ls_commands | grep -i ^d " # Removed because alias doesn't play wll with grep
alias l="$ls_commands $ls_opts $color"
	alias lg="$ls_commands $ls_opts | grep -i "
	alias ld="$ls_commands $ls_opts | grep -i ^d "
	alias lh="$ls_commands $ls_opts | head"
alias la="$ls_commands $ls_opts -a $color"
alias ll='ls --group-directories-first -F $ls_opts --color=always | less -R; ls --group-directories-first -F $ls_opts --color=always'

 
LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.sh=90'

##################################################
## Miscellaneous
##################################################

alias vi='vim'
alias emacsclient='emacsclient -n'
alias kick='kill `pgrep xcompmgr`'

#alias unrar='time unrar '
#alias 7z='time 7z '

alias start='systemctl start '
alias status='systemctl status '

##################################################
## Functions 
##################################################

## Advanced version of the standart shell command
## 'cd'. List directory immediately after the shell
## dives into it.
function cd (){
    builtin cd "$@"
    clear
    pwd
    ls --group-directories-first -Flth --color=auto
}

## Having an access to the builtin cd command is
## always good idea.
function cdd (){
    builtin cd "$@"
}

## Change current working directory to workspace.
## If workspace doesn't exist it will be created.
## As the name suggests workspace are being created
## on a dialy basis.
function today(){
    date=$(date +%Y-%m-%d)
    wrkspDir=~/workspace
    wrksp="$wrkspDir/$date/"


    if [ ! -d "$wrksp" ]
    then
        mkdir "$wrksp"
    fi

    cd "$wrksp"
}

##################################################
## Journaling (pastd)
##################################################

#if [ -n "$TMUX" ] && [ "$TERM" = "screen" ]
if [ -n "$TMUX" ]
then
    sessionName=$(tmux display-message -p '#S')
    windowIndex=$(tmux display-message -p '#I')
    windowName=$(tmux display-message -p '#W')
else
    sessionName="none"
    windowIndex=0
    windowName="bash" #TODO it is probably good idea to use the terminal escape sequence for title
fi 

shopt -s histappend

INSTANCEHISTFILE="$(initHistoryFile ${sessionName} ${windowIndex} ${windowName})"
# If the past daemon is runnig $INSTANCEHISTFILE will contain
# the a valid file name, otherwise it will contain "0".
# In case the daemon is not running we fall back to the 
# conventional .bash_history
if [ "${INSTANCEHISTFILE}" == "0" ] #|| [ $?  != 0 ]
then
    HISTFILE=~/".bash_history"
    PROMPT_COMMAND="history -a; history -c; history -r; "
    unset INSTANCEHISTFILE
else
    PS1="\[\033[0;32m\][•\u@\h \W]\$\[\033[0m\] "
    SESSIONHISTFILE=~/".pastd/bash/sessions/${sessionName}"
    HISTFILE="$SESSIONHISTFILE"
    PROMPT_COMMAND="history -a; history -c; history -r; recordInstanceHistory; "
fi

SHELLRECORDHISTORY=0

function onExit
{   
    if [ -n "${INSTANCEHISTFILE}" ]
    then
        rm "$INSTANCEHISTFILE"
        unset HISTFILE
    fi
}

function recordInstanceHistory
{   
    
    if [ $SHELLRECORDHISTORY -eq 0 ]
    then
        SHELLRECORDHISTORY=1
    else
        echo "$(history 1 | sed 's/^\s*[0-9][0-9]*\s\s*//')" >> "${INSTANCEHISTFILE}"
    fi
}
trap onExit EXIT

export LD_LIBRARY_PATH=/usr/bib
