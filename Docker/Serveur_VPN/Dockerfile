FROM debian:jessie-slim
RUN echo "deb http://deb.debian.org/debian/ unstable main" > /etc/apt/sources.list.d/unstable-wireguard.list
RUN printf 'Package: *\nPin: release a=unstable\nPin-Priority: 150\n' > /etc/apt/preferences.d/limit-unstable
RUN apt-get update
RUN apt-get -y install iptables apt-utils iproute2 net-tools systemd telnet nano iputils-ping tcpdump inetutils-traceroute quagga
RUN apt-get install -y --force-yes wireguard
RUN apt-get -f install
COPY ./quagga /etc/quagga
COPY serveurVPN.sh /home/
COPY wg0.conf /etc/wireguard
RUN ["chmod", "+x", "/home/serveurVPN.sh"]
RUN mkdir /etc/scripts
ENV PATH "/etc/scripts:$PATH"
ENTRYPOINT /etc/init.d/quagga start && /bin/bash
#RUN wg set wg0 peer IkXYK3BwdPi6taY13FA4yCcbr4+zXW70peWhKWsMAiQ= allowed-ips 10.0.0.4