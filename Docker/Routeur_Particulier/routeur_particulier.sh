ifconfig eth1 0.0.0.0
ifconfig eth1 120.0.32.2 netmask 255.255.240.0
ifconfig eth2 0.0.0.0
ifconfig eth2 120.0.34.1 netmask 255.255.255.0
route add -net 120.0.33.0/24 gw 120.0.32.1