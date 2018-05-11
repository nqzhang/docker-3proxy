#!/bin/bash

if [ -z "$PROXY_LOGIN" ] || [ -z "$PROXY_PASSWORD" ]; then
			echo >&2 'error: proxy is uninitialized, variables is not specified '
			echo >&2 '  You need to specify PROXY_LOGIN and PROXY_PASSWORD'
			exit 1
fi

if [ "$1" = "start_proxy" ]; then
	echo "
nserver 1.1.1.1
nserver 8.8.8.8
nserver 8.8.4.4
nscache 65536
nsrecord www.porno.com 127.0.0.1
pidfile /etc/3proxy/3proxy.pid
logformat "%d-%m-%Y %H:%M:%S %U %C:%c %R:%r %O %I %T"
rotate 7
users $PROXY_LOGIN:CL:$PROXY_PASSWORD
auth strong
proxy -p3128
socks -p1080
flush
" > /etc/3proxy/3proxy.cfg
	echo "Proxy user login:         $PROXY_LOGIN"
	echo "Proxy user password:      $PROXY_PASSWORD"
	echo
	echo "Proxy process started!"
	/etc/3proxy/3proxy /etc/3proxy/3proxy.cfg
else
	exec "$@"
fi

	


