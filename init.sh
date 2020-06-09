#!/bin/bash
#
### BEGIN INIT INFO
# Provides:          portfwd
# Required-Start:    $local_fs $network $named $time $syslog
# Required-Stop:     $local_fs $network $named $time $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: A low performance port forwarding implementation
# Description:       A low performance port forwarding implementation
### END INIT INFO
#

NAME=go-shadowsocks2
DAEMON=/etc/go-shadowsocks2/start.sh
PIDFILE=/var/run/$NAME.pid

test -x $DAEMON || exit 0

case "$1" in
'start')
  start-stop-daemon --oknodo --exec $DAEMON -m -p $PIDFILE -b --start
  ;;
'stop')
  start-stop-daemon --oknodo --exec $DAEMON -p $PIDFILE --stop
  rm -f $PIDFILE
  ;;
'restart')
  start-stop-daemon --oknodo --exec $DAEMON -m -p $PIDFILE --stop
  start-stop-daemon --oknodo --exec $DAEMON -m -p $PIDFILE -b --start
  ;;
'status')
  if [ -f $PIDFILE ]; then
    if kill -0 $(cat "$PIDFILE"); then
      echo "$NAME is running"
    else
      echo "$NAME process is dead, but pidfile exists"
    fi
  else
    echo "$NAME is not running"
  fi
  ;;
*)
  echo "Usage: $0 start|stop|restart|status"
  exit 2
  ;;
esac

exit 0
