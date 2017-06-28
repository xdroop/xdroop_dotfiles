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
alias now="date '+%s'"
alias today='export TODAY=`date +%Y-%m-%d` ; echo $TODAY'

# name resolution macros
alias digs='dig +short'
alias digg='dig @8.8.8.8'
alias diggs='dig +short @8.8.8.8'

# sudo 
alias fuck='sudo $(history -p \!\!)'

# grep
export GREP_COLOR="1;32"
export GREP_OPTIONS=--color=auto

# https://superuser.com/questions/611538/is-there-a-way-to-display-a-countdown-or-stopwatch-timer-in-a-terminal
function countdown(){
   date1=$((`date +%s` + $1)); 
   while [ "$date1" -ge `date +%s` ]; do 
     echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     sleep 0.1
   done
}

# This is a lot of bullshit which is necessary to have nice session displays in screen when
#  connected to either C6 or C7 systems -- because RedHat changed it in RHEL7/C7. This is a
#  portable way to deal with it which means I can push one file out via ansible, which makes
#  ansible simpler.
#
# Are we interactive?
if [ "$PS1" ]; then
    # No RPM -- no point.
    if [ -x /bin/rpm ] ; then
        # CentOS
        RHVERSION=`rpm -q --queryformat '%{VERSION}' centos-release`
        if [ -z "$RHVERSION" ]; then
                # RedHat
                RHVERSION=`rpm -q --queryformat '%{RELEASE}' redhat-release-server | awk -F. '{print $1}'`
        fi
        if [ "$RHVERSION" ]; then
            # OK, CentOS or RedHat
            case $TERM in
            xterm*)
                PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
                ;;
            screen)
                PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
                if [ $RHVERSION -ge 7 ]; then
                    # Fuck
                    PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
                fi
                ;;
            *)
                [ -e /etc/sysconfig/bash-prompt-default ] && PROMPT_COMMAND=/etc/sysconfig/bash-prompt-default
                ;;
            esac
            export PROMPT_COMMAND
        fi
    fi
fi

