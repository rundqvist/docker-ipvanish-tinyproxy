# Docker OpenVPN client for IPVanish
A small VPN client based on Alpine Linux.

[![Docker pulls](https://img.shields.io/docker/pulls/rundqvist/ipvanish-tinyproxy.svg)](https://hub.docker.com/r/rundqvist/ipvanish-tinyproxy)

---

### Please note: Image is replaced with improved version

Please use the new image instead: [https://hub.docker.com/r/rundqvist/openvpn-tinyproxy](https://hub.docker.com/r/rundqvist/openvpn-tinyproxy).

The new image is an improved version, it has matching features, support for more vpn providers and is actively developed.

Alternatively, check out these images with similar functionality:
* OpenVPN with SNI Proxy: [https://hub.docker.com/r/rundqvist/openvpn-sniproxy](https://hub.docker.com/r/rundqvist/openvpn-sniproxy)
* OpenVPN only: [https://hub.docker.com/r/rundqvist/openvpn](https://hub.docker.com/r/rundqvist/openvpn)
* SmartDNS for geo unblocking [https://hub.docker.com/r/rundqvist/smartdns](https://hub.docker.com/r/rundqvist/smartdns)

This image will however not be deleted, so feel free to continue using it. But it has been discontinued and will not maintained.

---

## Do you find this container useful? 
Please support the development by making a small donation.

[![Support](https://img.shields.io/badge/support-Flattr-brightgreen)](https://flattr.com/@rundqvist)
[![Support](https://img.shields.io/badge/support-Buy%20me%20a%20coffee-orange)](https://www.buymeacoffee.com/rundqvist)
[![Support](https://img.shields.io/badge/support-PayPal-blue)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=SZ7J9JL9P5DGE&source=url)

## Features
* Connect to random server
* Reconnects if connection breaks
* Http(s) proxy on port 8888 
* Killswitch (container stops if openvpn quits)
* Compact (compressed size on dockerhub only 5 MB, running size 10 MB)
* Docker health check

## Requirements
* An [IPVanish](https://www.ipvanish.com/?a_bid=48f95966&a_aid=5f3eb2f0be07f) VPN account

[![Sign up](https://img.shields.io/badge/sign_up-IPVanish_VPN-6fbc44)](https://www.ipvanish.com/?a_bid=48f95966&a_aid=5f3eb2f0be07f)

## Components
* Alpine Linux
* OpenVPN
* Tinyproxy

## Configuration
| Variable | Usage |
|----------|-------|
| USERNAME | Your IPVanish username |
| PASSWORD | Your IPVanish password |
| COUNTRY | ISO 3166-1 alpha-2 country code supported by IPVanish (see https://www.ipvanish.com/software/configs/) |
| PNET | Add your local network like '192.168.0.0' to make container network accessible |
| RANDOMIZE | If true, connects to random remote at connect |
| PRIO_REMOTE | Sets specified remote as first connection attempt (does not work with RANDOMIZE=true) |

## Run
```
$ sudo docker run \
    -d \
    --cap-add=NET_ADMIN \
    --device=/dev/net/tun \
    --name=vpn \
    --dns 84.200.69.80 \
    --dns 84.200.70.40 \
    -p 8888:8888 \
    -e 'USERNAME=[username]' \
    -e 'PASSWORD=[password]' \
    -e 'COUNTRY=[country code]' \
    -e 'PNET=[local network]' \
    -e 'RANDOMIZE=[true/false]' \
    -e 'PRIO_REMOTE=[first remote to connect to]' \
    rundqvist/ipvanish-tinyproxy
```

## Use
Proxy your traffic through [docker server ip]:8888 or use --net container:vpn on containers who shall tunnel traffic.  
If using --net option, remember to configure PNET or network will not be reachable. Also, the ports you want to reach in the other container must be configured in the vpn container.

## Issues
Please report issues at https://github.com/rundqvist/docker-ipvanish-tinyproxy/issues
