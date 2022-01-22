FROM debian:jessie-slim
RUN apt-get update
RUN apt-get -y install iptables apt-utils iproute2 net-tools systemd telnet nano iputils-ping tcpdump inetutils-traceroute quagga isc-dhcp-server
RUN apt-get -f install
COPY  ./quagga /etc/quagga
COPY  ./dhcp/dhcpd.conf /etc/dhcp
COPY box_ext.sh /home/
RUN ["chmod", "+x", "/home/box_ext.sh"]
RUN mkdir /etc/scripts
ENV PATH "/etc/scripts:$PATH"
ENTRYPOINT /etc/init.d/quagga start && /bin/bash