#!/bin/sh

### BEGIN INIT INFO
# Provides:          Hcron
# Required-Start:    $remote_fs $syslog
# Default-Start:     2 3 4 5
# Short-Description: Ensure Hcron is ready to run
### END INIT INFO

PATH=/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=/bin/Hcron
NAME=Hcron
DESC="redundant cron middleware"
CONFIG=/etc/Hcron/Hcron.conf

#includes lsb functions
. /lib/lsb/init-functions

#includes service defaults, if any
[ -r /etc/default/Hcron ] && . /etc/default/Hcron

test -f $CONFIG || exit 0
test -f $DAEMON || exit 0

case "$1" in
    start|restart|reload|force-reload)
        log_daemon_msg "Bootstrapping $DESC" "$NAME"
        $DAEMON --conf=$CONFIG --generate > /dev/null 2>&1

        if [ $? -eq 0 ]; then
            log_end_msg 0
        else
            log_end_msg 1
        fi
        ;;
    stop)
        log_daemon_msg "No-op $DESC" "$NAME"
        log_end_msg 0
        ;;
    *)
       echo "Usage: /etc/init.d/$NAME {start|stop|restart|reload|force-reload}" >&2
       exit 1
        ;;
esac

exit 0