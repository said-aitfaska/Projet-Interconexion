ifconfig eth1 0.0.0.0
ifconfig eth1 120.0.33.68 netmask 255.255.255.192
route add -net 120.0.33.0/24 gw 120.0.33.65