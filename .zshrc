#!/bin/zsh -xv

###############################################################################
############################# dumb terminals ##################################
###############################################################################

if [[ "$TERM" == "dumb" ]]; then
    return
fi
if [[ "$TERM" != "screen-256color" && "$TERM" != "screen" && "$TERM" != "eterm-color" ]]; then
    tmux -2
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git command-not-found debian encode64 last-working-dir nyan lol pip sprunge sublime urltools)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
source /home/hunter/bin/clickpad.sh #Enable right clicking

# Don't duplicate history lines.
setopt hist_ignore_all_dups

# Can now prevent something from being added to history by prepending a space
setopt hist_ignore_space

# more powerful globbing
setopt extendedglob

# autocmoplete switches even on aliases
setopt completealiases

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# don't change into a directory unless I tell you to!
unsetopt autocd

# don't autocorrect. just autocomplete.
unsetopt correct_all
unsetopt correct

# for python virtualenvs
if [[ -x /usr/local/bin/virtualenvwrapper.sh || -x /usr/bin/virtualenvwrapper.sh ]]; then
    WORKON_HOME=~/.python-virtualenvs
    source virtualenvwrapper.sh
fi

# some variables for building debian packages
export DEBEMAIL="hunter.scott@gatech.edu"
export DEBFULLNAME="Hunter Scott"

###############################################################################
################################# Other Junk ##################################
###############################################################################

. ~/src/z/z.sh

###############################################################################
############################### C code tagging ################################
###############################################################################

CODEDIR=~/src
alias mktags='cd $CODEDIR && etags "`find $CODEDIR -name *.[h|c|py|cpp|cc|hh|hpp|java]`" && cd -'
alias mktagscurrent='etags `find . -name "*.[h|c|py|cpp|cc|hh|hpp|java]"`'

###############################################################################
################################## Aliases ####################################
###############################################################################

# make ls more friendly with lesspipe
#  note that we're using the pipe option, so we don't get nice %-progress
#  indicators.
export LESSOPEN="|lesspipe %s"

# editor
alias e='emacsclient'
alias enw='emacsclient -nw'
alias enc='emacsclient -nc'

# make ls easier to type
alias la='ls -a'
alias ll='ls -l'
alias lal='ls -al'
alias lla='ls -al'
compdef _ls la=ls
compdef _ls ll=ls
compdef _ls lal=ls
compdef _ls lla=ls

# working with ACLs
alias ga='getfacl'
alias sa='setfacl'
compdef _getfacl ga=getfacl
compdef _setfacl sa=setfacl

# call this to update the git vars in our command line
alias gup='chpwd'

alias rolldice="rolldice -s"

# tmux stuff
alias tmux='tmux -2'
alias teamocil="teamocil --here"

alias open="gnome-open"

###############################################################################
#################################### prompt ###################################
###############################################################################

# turn on command substitution in the prompt!
# Also parameter expansion and artihmetic expansion, but we don't use those.
setopt promptsubst
autoload colors && colors

###############################################################################

# [user@host (chroot?) (git?) dir]$ 
# ^                              ^^
color_brackets="%{$fg_bold[red]%}"

# [user@host (chroot?) (git?) dir]$ 
#  ^^^^
color_username_normal="%{$fg_bold[green]%}"

# [root@host (chroot?) (git?) dir]$ 
#  ^^^^
color_username_root="%{$fg_bold[yellow]%}"

# [user@host (chroot?) (git?) dir]$ 
#      ^
color_at="%{$fg_bold[green]%}"

# [user@host (chroot?) (git?) dir]$ 
#       ^^^^
color_host_normal="%{$fg_bold[green]%}"

# [user@important (chroot?) (git?) dir]$ 
#       ^^^^^^^^^
color_host_special="%{$fg_bold[red]%}"

# [user@host (chroot?) (git?) dir]$ 
#             ^^^^^^
color_host_chroot="%{$fg_bold[yellow]%}"

# [user@host (chroot?) (git?) dir]$ 
#                       ^^^
color_git_clean="%{$fg[green]%}"

# [user@host (chroot?) (git?) dir]$ 
#                       ^^^
color_git_dirty="%{$fg[yellow]%}"

# [user@host (chroot?) (git?) dir]$ 
#                             ^^^
color_dir="%{$fg_bold[blue]%}"

###############################################################################

# gets the name of the current branch
# saves result as a var
git_branch()
{
    git_branch_string="$(git symbolic-ref HEAD 2>/dev/null)"
    git_branch_string="${git_branch_string##*/}"
    git_branch_string="${git_branch_string:-no branch}"
}

# gets whether the current worktree has changes
# changes color of the branch name
git_dirty()
{
    if [[ -n "$(git status -s --ignore-submodules=dirty --porcelain 2> /dev/null)" ]]; then
        git_dirty_string=$color_git_dirty
    else
        git_dirty_string=$color_git_clean
    fi
}

git_prompt() {
    if [[ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]];
    then
        git_prompt_string="%{$fg_bold[blue]%} ("$git_dirty_string$git_branch_string"%{$fg_bold[blue]%})"
    else
        unset git_prompt_string
    fi
}
function toggle_git()
{
    if [ -z "$DO_ZSH_GIT" ] ;
    then
        echo "Will not include git status in prompt"
        DO_ZSH_GIT="foo"
    else
        echo "Will include git status in prompt"
        DO_ZSH_GIT=""
    fi
}

# start with git status enabled
DO_ZSH_GIT=""

#              command                       # part
PROMPT=$color_brackets"["                    # [
PROMPT=$PROMPT'$prompt_user_string'          # username
PROMPT=$PROMPT'$color_at'"@"         # @
PROMPT=$PROMPT'$prompt_host_string'          # host
PROMPT=$PROMPT'$color_dir'" %1~"       # dir
PROMPT=$PROMPT'$git_prompt_string'           # git status
PROMPT=$PROMPT'$color_brackets'"]"            # ]
PROMPT=$PROMPT"%(#.# .$ )"                    # root gets a #, normal a $.
PROMPT=$PROMPT"%{$reset_color%}"             # reset   

###############################################################################
########################## emacs editing things ###############################
###############################################################################

# Local Variables:
# mode: sh
# End:


#path edit for Canopy
#export PATH = $PATH:/home/hunter/Canopy
export PATH=/usr/local/share/npm/bin:$PATH


#jump, mark, unmark, marks
export MARKPATH=$HOME/.marks
function jump { 
    cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
    }
function mark { 
        mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}
function unmark { 
    rm -i $MARKPATH/$1 
    }
function marks {
        ls -l $MARKPATH | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

