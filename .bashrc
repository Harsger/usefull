export PS1="\[\033[1;32m\] @ \H @ \d \A < \W > : \[\033[0m\]"

PROMPT_COMMAND='echo -ne "\033]0;$(basename `pwd`)\007"'

PATH=~/.local/bin:$PATH:./:~/bin:/sbin:

#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias ls='ls --color'
alias ll='ls -lh'
alias lm='ls -rthl;pwd'
alias la='ls -rthla'

alias ..='cd ..'
alias cdb='..;lm'

#source ~/ROOT/bin/thisroot.sh
alias loadroot='source /home/harsger/ROOT/bin/thisroot.sh'
alias root='root -l'

alias loadhistpresent='. /home/harsger/marabou/iniHprPath'
alias HI='HistPresent'
