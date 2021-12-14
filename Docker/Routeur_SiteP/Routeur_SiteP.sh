#!/bin/bash
ip link set dev eth0 up
ip addr add 120.0.33.1/24 dev eth0
ip link set dev eth1 up
ip addr add 120.0.33.65/24 dev eth1

# Static routing 
ip route add 120.0.32.0/20 via 120.0.33.2
ip route add 120.0.33.128/26 via 120.0.33.3
#echo 1 > /proc/sys/net/ipv4/ip_forward

service isc-dhcp-server start
service quagga start

# Drop it all
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Allow ping
iptables -t filter -A OUTPUT -p icmp -j ACCEPT
iptables -t filter -A INPUT -p icmp -j ACCEPT
iptables -t filter -A FORWARD -p icmp -j ACCEPT

# Allow Rip routing
iptables -A INPUT -p udp --dport 520 -j ACCEPT
iptables -A OUTPUT -p udp --dport 520 -j ACCEPT
iptables -A FORWARD -p udp --dport 520 -j ACCEPT

# Allow DNS
iptables -t filter -A FORWARD -d 1.1.1.2/24 -p udp --dport 53 -j ACCEPT
iptables -t filter -A FORWARD -s 1.1.1.2/24 -p udp --sport 53 -j ACCEPT

# Allow VoIP
iptables -t filter -A FORWARD -d 120.0.33.67/26 -p tcp --dport 5060 -j ACCEPT
iptables -t filter -A FORWARD -s 120.0.33.67/26 -p tcp --sport 5060 -j ACCEPT

# Allow FTP
iptables -A FORWARD -d 120.0.33.66/26 -p tcp --dport 21 -j ACCEPT
iptables -A FORWARD -s 120.0.33.66/26 -p tcp --sport 21 -j ACCEPT
iptables -A FORWARD -p tcp --sport 1024: --dport 1024: -j ACCEPT

# Allow DMZ
iptables -t filter -A FORWARD -d 120.0.33.68/26 -p tcp --dport 80 -j ACCEPT
iptables -t filter -A FORWARD -s 120.0.33.68/26 -p tcp --sport 80 -j ACCEPT



