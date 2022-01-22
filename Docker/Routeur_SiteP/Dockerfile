FROM debian:jessie-slim
RUN apt-get update
RUN apt-get -y install iptables apt-utils iproute2 net-tools systemd telnet nano iputils-ping tcpdump inetutils-traceroute quagga isc-dhcp-server
RUN apt-get -f install
COPY  ./quagga /etc/quagga
COPY routeur_sitep.sh /home/
COPY  ./dhcp/dhcpd.conf /etc/dhcp
RUN ["chmod", "+x", "/home/routeur_sitep.sh"]
RUN mkdir /etc/scripts
ENV PATH "/etc/scripts:$PATH"
ENTRYPOINT /etc/init.d/quagga start && /bin/bash