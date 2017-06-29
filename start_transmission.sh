#!/bin/sh

#Wait for openvpn service to start
#There's probably a better way to do this, but sleeping 10 seconds seems to be enough time
echo "waiting 10 seconds for openvpn container to start"
sleep 10

#Start transmission with logs going to foreground/stdout
transmission-daemon --config-dir /etc/transmission/ -f --log-info
