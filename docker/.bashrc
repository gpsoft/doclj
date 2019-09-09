export SHELL=/bin/bash
export PATH=$JAVA_HOME/bin:$PATH
export EDITOR=/usr/bin/vim
export LS_OPTIONS='--color=auto -F --show-control-chars'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -lrt'

alias repl='clojure -A:rebel-readline'
