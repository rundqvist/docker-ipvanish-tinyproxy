# Docker OpenVPN client for IPVanish
A very tiny VPN client based on Alpine Linux. 

## Features
* Connect to random server
* Reconnects if connection breaks
* Http(s) proxy on port 8888 

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

## Build
```
$ sudo docker build -t rundqvist/docker-ipvanish-tinyproxy .
```

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
    rundqvist/docker-ipvanish-tinyproxy
```

# Use
Proxy your traffic through [docker server ip]:8888 or use --net container:vpn to containers who shall tunnel traffic.