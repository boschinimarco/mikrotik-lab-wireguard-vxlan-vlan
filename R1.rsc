# oct/13/2023 21:50:10 by RouterOS 7.5
# software id = 
#
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/port
set 0 name=serial0
set 1 name=serial1
/ip address
add address=10.10.10.1/30 interface=ether2 network=10.10.10.0
add address=10.10.10.5/30 interface=ether3 network=10.10.10.4
/ip dhcp-client
add interface=ether1
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
/system identity
set name=R1
/tool romon
set enabled=yes
