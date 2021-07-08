#  
# /etc/profile.d/davem.sh
#
# Bash Customizations I like because I'm picky
#  from dave@xdroop.com 
#
# I do it this way because when I'm working with a system I tend to end up
#  either using 'root' or some service account and I want my customizations
#  present. I am also the only, or primary, admin user on systems I do this
#  way, otherwise this ends up as .bashrc.

# Time functions
alias now="/usr/bin/date '+%s'"
alias today='export TODAY=`/usr/bin/date +%Y-%m-%d` ; echo $TODAY'
alias sdate='/usr/bin/date --rfc-3339=seconds'

# name resolution macros
alias digs='dig +short'
alias digg='dig @8.8.8.8'
alias diggs='dig +short @8.8.8.8'

# Because why not
alias shruggie="echo '¯\_(ツ)_/¯'"

# Because sudo 
alias fuck='sudo $(history -p \!\!)'

# ls long time reverse
alias l8r='ls -ltr --color=auto'

# grep
export GREP_COLOR="1;32"
alias grep='grep --color=auto'

# make/change directory
function mcd(){
    mkdir $1
    if [ -d $1 ]; then
      cd $1
    fi
}

# edit the ~/.ssh/known_hosts file to remove the passed line number.
#  source: https://chainsawonatireswing.com/2012/04/06/an-easier-quicker-way-to-edit-the-known_hosts-file-when-an-ssh-server-changes-its-host-key/
trim-ssh () {
  cp ~/.ssh/known_hosts ~/.ssh/known_hosts_$(/usr/bin/date +%Y%m%d-%H%M%S) ;
  sed -e "$1d" ~/.ssh/known_hosts > ~/.ssh/known_hosts_new ;
  mv -f ~/.ssh/known_hosts_new ~/.ssh/known_hosts ;
  chmod 644 ~/.ssh/known_hosts
}

# wait for the indicated host to be responsive to pings
# https://serverfault.com/questions/152795/linux-command-to-wait-for-a-ssh-server-to-be-up
waiton() { ping $1 | grep --line-buffered "bytes from" | head -1 > /dev/null ; }

# merge github repo I forked from into my local fork
# I always forget how to do this
alias git-pull-master='git fetch upstream ; git merge upstream/master ; git push'

# https://superuser.com/questions/611538/is-there-a-way-to-display-a-countdown-or-stopwatch-timer-in-a-terminal
function countdown(){
   date1=$((`/usr/bin/date +%s` + $1)); 
   while [ "$date1" -ge `/usr/bin/date +%s` ]; do 
     echo -ne "$(/usr/bin/date -u --/usr/bin/date @$(($date1 - `/usr/bin/date +%s`)) +%H:%M:%S)\r";
     sleep 0.1
   done
}

# Screen session and terminal window titles
#  This "should" be reasonably portable/harmless-to-systems-that-don't-understand
#  Based on https://superuser.com/questions/560223/set-gnu-screen-title-within-ssh
#  plus a whole lot of fucking around
# If we are interactive
if [ "$PS1" ]; then
  # If we are in a screen session, print out an escape sequence for the screen session title.
  # Either way, print out an escape sequence for putty/kitty/xterm to use as a window title.
PROMPT_COMMAND='if [ "$TERM" == "screen" ] ;then \
  printf "\033k%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"; \
fi; \
printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
fi
