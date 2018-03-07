#!/bin/sh

: ${COUNTRY:?"-e COUNTRY='...' missing"}
: ${USERNAME:?"-e USERNAME='...' missing"}
: ${PASSWORD:?"-e PASSWORD='...' missing"}

echo "$USERNAME" > auth.conf
echo "$PASSWORD" >> auth.conf

chmod 600 auth.conf

#
# Make container accessible from private network
#
if expr "${PNET}" : '[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*$' >/dev/null; then
	route add -net ${PNET} netmask 255.255.255.0 gw $(route -n | grep 'UG[ \t]' | awk '{print $2}')
fi

#
# Start tinyproxy
#
tinyproxy

#
# Copy one config file
#
find ./config/ -name "*${COUNTRY}*" -print | head -1 | xargs -I '{}' cp {} ./config.ovpn

#
# Remove remote and verify-x509-name
#
sed -i '/remote /d' config.ovpn
sed -i '/verify-x509-name /d' config.ovpn

#
# Create list of allowed clients (and make sure it is not too long)
#
find ./config/ -name "*${COUNTRY}*" -exec sed -n -e 's/^remote \(.*\) \(.*\)/\1/p' {} \; > allowed-clients
echo "$(tail -n 32 allowed-clients)" > allowed-clients

#
# Add allowed clients as remotes
#
find . -name "allowed-clients" -exec sed -n -e 's/^\(.*\)/remote \1 /p' {} \; >> config.ovpn

#
# Randomize
#
echo 'remote-random' >>  config.ovpn

#
# Connect
#
openvpn \
	--script-security 2 \
	--config config.ovpn \
	--auth-user-pass auth.conf \
	--mute-replay-warnings \
	--tls-verify "tls-verify.sh allowed-clients"
