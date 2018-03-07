FROM	alpine:latest

MAINTAINER	mattias.rundqvist@icloud.com

RUN	apk update && \
	apk upgrade && \
	apk add \
	openvpn \
	tinyproxy

WORKDIR	/etc/openvpn

COPY	connect.sh connect.sh
COPY    tls-verify.sh tls-verify.sh

RUN	mkdir config && \
	wget https://www.ipvanish.com/software/configs/configs.zip -P config/ && \
	unzip config/configs.zip -d config && \
	mv config/ca.ipvanish.com.crt . && \
	chmod 755 tls-verify.sh && \
	chmod 755 connect.sh && \
	sed -i 's/Allow /#Allow /g' /etc/tinyproxy/tinyproxy.conf && \
	sed -i 's/#DisableViaHeader /DisableViaHeader /g' /etc/tinyproxy/tinyproxy.conf

ENV	COUNTRY='NL'
ENV	USERNAME=''
ENV	PASSWORD=''
ENV	PNET='192.168.0.0'

CMD	sh connect.sh
