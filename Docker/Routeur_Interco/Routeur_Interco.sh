#!/bin/bash
ip addr flush dev eth0
ip addr flush dev eth1

# Set address on eth0
ip link set dev eth0 up
ip addr add 120.0.32.3/20 dev eth0

# Set address on eth1
ip link set dev eth1 up
ip addr add 120.0.48.5/20 dev eth1

# Static routing 
ip route add 120.0.33.0/24 via 120.0.32.1
ip route add 120.0.34.0/24 via 120.0.32.2

