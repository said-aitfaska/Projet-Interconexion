ifconfig eth2 0.0.0.0
ifconfig eth2 120.0.33.2 netmask 255.255.255.0
ifconfig eth1 0.0.0.0
ifconfig eth1 120.0.32.1 netmask 255.255.240.0
route add -net 120.0.33.64/26 gw 120.0.33.1
route add -net 120.0.33.128/26 gw 120.0.33.3
route add -net 120.0.34.0/24 gw 120.0.32.2
route add -net 192.168.1.0/24 gw 120.0.32.2