#!/bin/sh

VPNIP=$(wget http://ipecho.net/plain -O - -q)
RC=$?
HOSTIP=$(cat hostip)

if [ $RC -eq 1 ]; then
    echo "Failed to resolve VPN IP"
    exit 1;
fi

if [[ ${HOSTIP:0:1} = "1" ]]; then
    echo "Failed to resolve host IP"
    exit 1;
fi

if [ $RC":"$VPNIP = $HOSTIP ]; then
	echo "VPN IP same as host IP"
	exit 1;
fi

exit 0;