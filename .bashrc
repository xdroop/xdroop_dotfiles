# .bashrc

# User specific aliases and functions

alias git-pull-master='git fetch upstream ; git merge upstream/master ; git push'

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

alias fuck='sudo $(history -p \!\!)'

