export EDITOR="vim"

set -o vi

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export HISTIGNORE=' *:ls:lt:pwd:clear:cd:q:b:h:fg:e:ll:tp:td:tr:sl:R:qA:qB:qstat:w:who:..:screen'

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color) color_prompt=yes;;
esac
 
force_color_prompt=yes
 
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi
#define BLACK "\033[22;30m"
#define RED "\033[22;31m"
#define GREEN "\033[22;32m"
#define BROWN "\033[22;33m"
#define BLUE "\033[22;34m"
#define PURPLE "\033[22;35m"
#define CYAN "\033[22;36m"
#define GREY "\033[22;37m"
#define DARK_GREY "\033[01;30m"
#define LIGHT_RED "\033[01;31m"
#define LIGHT_GREEN "\033[01;32m"
#define YELLOW "\033[01;33m"
#define LIGHT_BLUE "\033[01;34m"
#define LIGHT_PURPLE "\033[01;35m"
#define LIGHT_CYAN "\033[01;36m"
#define WHITE "\033[01;37m"

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[22;36m\]\u \[\033[01;35m\]\t:\[\033[01;32m\]\w\[\033[01;32m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

## If this is an xterm set the title to user@host:dir
#case "$TERM" in
    #xterm*|rxvt*)
    #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    #;;
    #*)
    #;;
#esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
fi


# User specific aliases and functions
#-------------------
# Personnal Aliases
#-------------------
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# -> Prevents accidentally clobbering files.
alias c='clear; ls -hF --color=auto'
alias mkdir='mkdir -p'
alias h='history'
alias j='jobs -l'
#alias r='rlogin'
# The 'ls' family (this assumes you use the GNU ls)
alias ll="ls -alF --color=auto"
alias la='ls -Al'               # show hidden files
alias ls='ls -ahF --color=auto'    # add colors for filetype recognition
alias lx='ls -lXB'              # sort by extension
alias lk='ls -lSr'              # sort by size
alias lc='ls -lcr'        # sort by change time 
alias lu='ls -lur'        # sort by access time  
#alias lr='ls -lR'               # recursive ls
alias lt='ls -altr'              # sort by date
alias ltt='ls -altr | tail'              # sort by date
alias l='ls -altr'              # sort by date
alias lm='ls -al |more'         # pipe through 'more'
alias tree='tree -Csu'        # nice alternative to 'ls'

alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bashrc'
alias last='vim `ls -t|head -n1`'
alias last2='vim -O `ls -t|head -n2`'
alias last3='vim -p `ls -t|head -n3`'
alias cl='cat `ls -t|head -n1`'
alias cl2='cat `ls -t|head -n2`'
alias hl='head -v `ls -t|head -n1`'
alias hl2='head -v `ls -t|head -n2`'
alias tl='tail -v `ls -t|head -n1`'
alias tl2='tail -v `ls -t|head -n2`'
alias wl='wc -l'


alias b='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias .4='cd ../../..'
alias .5='cd ../../../..'


function gg()
{ head -n1 $2 ; grep $1 $2; }

#-----------------------------------
# File & strings related functions:
#-----------------------------------
# Find a file with a pattern in name:
function f()
{ ls -l | grep $* ; }
function f1()
{ ls    | grep $* ; }
function ff()
{ find . -type f -iname '*'$*'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe()
{ find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }
# find pattern in a set of filesand highlight them:
function fstr()
{
    OPTIND=1
    local case=""
    local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
        i) case="-i " ;;
        *) echo "$usage"; return;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    local SMSO=$(tput smso)
    local RMSO=$(tput rmso)
    find . -type f -name "${2:-*}" -print0 |
    xargs -0 grep -sn ${case} "$1" 2>&- | \
    sed "s/$1/${SMSO}\0${RMSO}/gI" | more
}

function lowercase()  # move filenames to lowercase
{
    for file ; do
        filename=${file##*/}
        case "$filename" in
        */*) dirname==${file%/*} ;;
        *) dirname=.;;
        esac
        nf=$(echo $filename | tr A-Z a-z)
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
        else
            echo "lowercase: $file not changed."
        fi
    done
}


#----------------------------------------------------------------------------
# archive function
#----------------------------------------------------------------------------
function a1()
{
    if [ -e $1 ]; then
        if [ ! -d ARCHIVED ]; then mkdir ARCHIVED; fi
        export FILENAME=`echo $1 | awk -F '.' '{print $1}'`
        export SUFF=`echo $1 | awk -F '.' '{print $2}'`
        mv $1 ARCHIVED/${FILENAME}_swa_`date +%m%d%y`.$SUFF
    else
        echo "$1 not found."
    fi
}

function a()
{
    if [ -e $1 ]; then
        if [ ! -d ARCHIVED ]; then mkdir ARCHIVED; fi
        export FILENAME=`echo $1 | awk -F '.' '{print $1}'`
        export SUFF=`echo $1 | awk -F '.' '{print $2}'`
        cp $1 ARCHIVED/${FILENAME}_swa_`date +%m%d%y`.$SUFF
    else
        echo "$1 not found."
    fi
}

#----------------------------------------------------------------------------
# Compression shortcuts
#----------------------------------------------------------------------------
#tar.gz
tg() {
    tarfile=$1
    shift
    tar -czvf $tarfile $@
}

#tar.bz2
tb() {
    tar --bzip2 -cvf $tarfile $@
}

# Extract various compression formats
extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1        ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1       ;;
             *.rar)       rar x $1     ;;
             *.gz)        gunzip $1     ;;
             *.tar)       tar xf $1        ;;
             *.tbz2)      tar xjf $1      ;;
             *.tgz)       tar xzf $1       ;;
             *.zip)       unzip $1     ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}


#---- Cluster ----
alias qA="qsub -I -q A"
alias qB="qsub -I -q B"
alias qT="qsub -I -q T"
alias qexpress="qsub -I -q express"
alias e='exit'
alias q='qstat'
alias qs='qstat -s'
alias qn='qstat -n'


#----- Rscript ----
alias r="/usr/local/bin/Rscript --verbose"
alias r1="R CMD BATCH "
alias r2="/usr/local/bin/Rscript-2.15.3 --verbose"

#----- Screen -----
alias sr="screen -r "
alias ss="screen -S "
alias sl="screen -ls "
alias cleanscreen="screen -ls | tail -n +2 | head -n -2 | awk '{print $1}' | xargs -I{} screen -S {} -X quit"

#----- History
hg() { history | grep $1 | grep -v hsearch; }

#----- temp function for moving files to the New Vorti folder structure

function dvr()
{ diff $* /home/bssi/clients/Takeda/VORTIOXETINE_2013/RESULTS/DEV/GWAS/$*; }
