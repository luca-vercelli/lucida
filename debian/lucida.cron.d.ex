#
# Regular cron jobs for the lucida package
#
0 4	* * *	root	[ -x /usr/bin/lucida_maintenance ] && /usr/bin/lucida_maintenance
