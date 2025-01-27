#!/bin/bash

##
## Mike's .bash_profile file
##

source ~/dotfiles/common.sh

# Reload your .bash_profile file while your shell is running
alias resh="source ~/.bash_profile && echo '.bash_profile reloaded'"

#-------------------------------------------------------------------------------
# Autocomplete

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

#-------------------------------------------------------------------------------
# OSX settings

if [ "$MIKEN_OS" = "mac" ]; then
  # Enables colors in Mac OS X iTerm2
  if [ "$TERM" != "dumb" ]; then
    alias ls="ls --color=auto"
  else
    alias ls="ls -p"
  fi
else
  # This is a terrible word to type
  alias o="evince"
fi

#-------------------------------------------------------------------------------
# Prompt

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  eval "$(dircolors -b)"
  if [ "$TERM" != "dumb" ]; then
    alias ls='ls --color=auto'
  else
    # Show directories with a slash
    alias ls='ls -p'
  fi
fi

# If not running interactively, don't do anything
if [ -n "$PS1" ] ; then

  # don't put duplicate lines in the history. See bash(1) for more options
  # don't overwrite GNU Midnight Commander's setting of `ignorespace'.
  export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
  # ... or force ignoredups and ignorespace
  export HISTCONTROL=ignoreboth

  # append to the history file, don't overwrite it
  shopt -s histappend

  # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

  # check the window size after each command and, if necessary,
  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize

  # make less more friendly for non-text input files, see lesspipe(1)
  [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

  # set variable identifying the chroot you work in (used in the prompt below)
  # if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  #   debian_chroot=$(cat /etc/debian_chroot)
  # fi

  # set a fancy prompt (non-color, unless we know we "want" color)
  # case "$TERM" in
  #   xterm256-color) color_prompt=yes;;
  # esac

  # uncomment for a colored prompt, if the terminal has the capability; turned
  # off by default to not distract the user: the focus in a terminal window
  # should be on the output of commands, not on the prompt
  #force_color_prompt=yes

  # if [ -n "$force_color_prompt" ]; then
  #   if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  #     # We have color support; assume it's compliant with Ecma-48
  #     # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  #     # a case would tend to support setf rather than setaf.)
  #     color_prompt=yes
  #   else
  #     color_prompt=
  #   fi
  # fi

  # if [ "$color_prompt" = yes ]; then
  # green='\[\e[1;32m\]'
  # yellow='\[\e[1;33m\]'
  # blue='\[\e[1;34m\]'
  # red='\[\e[0;31m\]'

  parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
  }

  PS1="\[\e[1;32m\]\$(basename $(pwd))\[\e[1;34m\](\[\e[1;33m\]\$(parse_git_branch)\[\e[1;34m\]) \[\e[0;31m\]λ\[\e[00m\] "
  # else
  #   echo poop
  #   PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  # fi
  # unset color_prompt force_color_prompt

  # If this is an xterm set the title to user@host:dir
  # case "$TERM" in
  #   xterm*|rxvt*)
  #     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  #     ;;
  #   *)
  #     ;;
  # esac

  # enable programmable completion features (you don't need to enable
  # this, if it's already enabled in /etc/bash.bash_profile and /etc/profile
  # sources /etc/bash.bash_profile).
  if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#-------------------------------------------------------------------------------
# PATH

# This is for Node.js
export PATH="$HOME/local/bin:$PATH"

# Clojure
export PATH="$HOME/.cljr/bin:$PATH"

# My scripts
export PATH="~/dotfiles/bin:$PATH"

# Homebrew
export PATH="/usr/local/bin:$PATH"

export NODE_PATH=/usr/local/lib/node_modules

#-------------------------------------------------------------------------------
# fzf

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#-------------------------------------------------------------------------------
# history

shopt -s histappend

#-------------------------------------------------------------------------------
## end .bash_profile
