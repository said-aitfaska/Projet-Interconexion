#!/bin/bash

ip addr flush dev eth0
ip link set dev eth0 up
ip addr add 120.0.33.68/26 dev eth0