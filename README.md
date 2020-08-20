# Docker OpenVPN client for IPVanish
A small VPN client based on Alpine Linux.  
https://hub.docker.com/r/rundqvist/ipvanish-tinyproxy/

# Appreciate my work?
Do you find this container useful? Please consider a donation.

[![Donate](https://img.shields.io/badge/Donate-Flattr-brightgreen)](https://flattr.com/@rundqvist)
[![Donate](https://img.shields.io/badge/Donate-Buy%20me%20a%20coffee-orange)](https://www.buymeacoffee.com/rundqvist)
[![Donate](https://img.shields.io/badge/Donate-PayPal-blue)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=SZ7J9JL9P5DGE&source=url)

## Features
* Connect to random server
* Reconnects if connection breaks
* Http(s) proxy on port 8888 
* Killswitch (container stops if openvpn quits)
* Compact (compressed size on dockerhub only 5 MB, running size 10 MB)
* Docker health check

## Requirements
* An IPVanish VPN account [![Sign up](https://img.shields.io/badge/Sign_up-IPVanish_VPN-6fbc44)](https://www.ipvanish.com/?a_bid=48f95966&a_aid=5f3eb2f0be07f)

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