ifconfig eth1 0.0.0.0
ifconfig eth1 192.168.1.2 netmask 255.255.255.0
route add -net 120.0.34.0/24 gw 192.168.1.1
route add -net 192.168.2.0/24 gw 192.168.1.1
route add -net 120.0.32.0/20 gw 192.168.1.1
route add -net 120.0.33.0/24 gw 192.168.1.1
route add -net 120.0.33.64/26 gw 192.168.1.1