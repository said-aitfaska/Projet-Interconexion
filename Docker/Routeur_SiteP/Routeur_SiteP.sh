#!/bin/bash
ip link set dev eth0 up
ip addr add 120.0.33.1/24 dev eth0
ip link set dev eth1 up
ip addr add 120.0.33.65/24 dev eth1

# Static routing 
ip route add 120.0.32.0/20 via 120.0.33.2
ip route add 120.0.33.128/26 via 120.0.33.3
#echo 1 > /proc/sys/net/ipv4/ip_forward