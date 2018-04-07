# Docker OpenVPN client for IPVanish
A small VPN client based on Alpine Linux. 

## Features
* Connect to random server
* Reconnects if connection breaks
* Http(s) proxy on port 8888 
* Killswitch (container stops if no openvpn quits)
* Docker health check

## Installed packages
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