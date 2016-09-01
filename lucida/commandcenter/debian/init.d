#!/bin/sh
# kFreeBSD do not accept scripts as interpreters, using #!/bin/sh and sourcing.
if [ true != "$INIT_D_SCRIPT_SOURCED" ] ; then
    set "$0" "$@"; INIT_D_SCRIPT_SOURCED=true . /lib/init/init-d-script
fi
### BEGIN INIT INFO
# Provides:          lucida-commandcenter
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Lucida main server
# Description:       Lucida main server (HTTP, commandcenter)
### END INIT INFO

# Author: Luca Vercelli <luca.vercelli.to@gmail.com>

DESC="lucida-commandcenter"
DAEMON="/usr/bin/python /usr/lib/lucida-commandcenter/app.py"

# This is an example to start a single forking daemon capable of writing
# a pid file. To get other behaviors, implement do_start(), do_stop() or
# other functions to override the defaults in /lib/init/init-d-script.
# See also init-d-script(5)
