FROM debian:jessie-slim
RUN apt-get update
RUN apt-get -y install iptables apt-utils iproute2 net-tools systemd telnet nano iputils-ping tcpdump inetutils-traceroute quagga asterisk
RUN apt-get -f install
COPY  ./quagga /etc/quagga
COPY serveurVoIP.sh /home/
COPY ./asterisk/sip.conf /etc/asterisk/
COPY ./asterisk/extensions.conf /etc/asterisk/
COPY ./asterisk/users.conf /etc/asterisk/
RUN ["chmod", "+x", "/home/serveurVoIP.sh"]
RUN mkdir /etc/scripts
ENV PATH "/etc/scripts:$PATH"
ENTRYPOINT /etc/init.d/quagga start && /bin/bash