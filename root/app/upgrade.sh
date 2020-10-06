#!/bin/sh

PORT=$1
DNS=$(sed -n -e 's/^nameserver \(.*\)/\1/p' /etc/resolv.conf)

echo " -- HOW TO UPGRADE -- ";
echo " ";
echo "Upgrade guide for generic installation. Please check values if you have made advanced configuration.";
echo " ";

if [ -z "$PORT" ] ; then
    echo "WARNING: Portmapping for tinyproxy cannot be resolved automatically.";
    echo "If you have an existing portmapping to 8888, please run this script again with your port as argument."
    echo "Example: sudo docker exec [container name] /app/upgrade.sh [portnumber]";
    echo " ";
fi

echo "* To first remove your existing container, run:";
echo "sudo docker rm -f $HOSTNAME";
echo " ";

echo "* To create eqvivalent vpn container, run:";
echo "sudo docker run \\";
echo "    -d \\";
echo "    --cap-add=NET_ADMIN \\";
echo "    --device=/dev/net/tun \\";
echo "    --name=tinyproxy-openvpn \\";

for ip in $DNS ; do
    echo "    --dns $ip \\";
done

if [ ! -z "$PORT" ] ; then
    echo "    -p $PORT:8888 \\";
fi

if [ ! -z $PNET ] ; then
    echo "    -e 'NETWORK=$PNET' \\";
fi

echo "    -e 'VPN_PROVIDER=ipvanish' \\";
echo "    -e 'VPN_USERNAME=$USERNAME' \\";
echo "    -e 'VPN_PASSWORD=$PASSWORD' \\";
echo "    -e 'VPN_COUNTRY=$COUNTRY' \\";
echo "    -e 'VPN_RANDOM_REMOTE=$RANDOMIZE' \\";
echo "    rundqvist/tinyproxy-openvpn";

echo " ";
echo " -------------------- "
echo " ";
