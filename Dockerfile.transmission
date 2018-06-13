FROM alpine:3.7

LABEL "Maintainer"="Micheal Waltz <ecliptik@gmail.com>"

#Install transmission-daemon package
RUN apk --no-cache add \
	  transmission-daemon \
          ca-certificates

#Copy start script
COPY start_transmission.sh /etc

#Expose RPC and UPD ports
EXPOSE 9091
EXPOSE 20000

#Run start script since container needs to wait for openvpn service to connect
CMD sh /etc/start_transmission.sh
