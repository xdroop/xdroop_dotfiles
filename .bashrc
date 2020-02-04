# .bashrc

# User specific aliases and functions
#  aliases are in davem.sh now

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# https://superuser.com/questions/180148/how-do-you-get-screen-to-automatically-connect-to-the-current-ssh-agent-when-re
if [ -S "$SSH_AUTH_SOCK" ] && [ ! -h "$SSH_AUTH_SOCK" ]; then
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/agent/$(hostname)_ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/agent/$(hostname)_ssh_auth_sock

