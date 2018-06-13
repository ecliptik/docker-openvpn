FROM alpine:3.7

LABEL "Maintainer"="Micheal Waltz <ecliptik@gmail.com>"

#Install OpenVPN package
RUN apk --no-cache add \
	  openvpn \
          ca-certificates

#Copy OpenVPN configuration file
COPY ./vpn.ovpn /etc/openvpn/vpn.ovpn

#Run OpenVPN using the configuration file
ENTRYPOINT ["openvpn"]
CMD ["/etc/openvpn/vpn.ovpn"]
