#!/bin/sh

if [ $2 -eq 0 ] ; then
	grep -q "^`expr match "$3" ".* CN=\([^,]*\)"`$" "$1" && exit 0
	exit 1
fi

exit 0
