# oct/13/2023 21:47:56 by RouterOS 7.5
# software id = 
#
/interface bridge
add ingress-filtering=no name=bridge1 vlan-filtering=yes
/interface vlan
add interface=bridge1 name=vlan99 vlan-id=99
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/port
set 0 name=serial0
set 1 name=serial1
/interface bridge port
add bridge=bridge1 interface=ether1
add bridge=bridge1 interface=ether2 pvid=10
add bridge=bridge1 interface=ether3 pvid=20
add bridge=bridge1 interface=ether4
/interface bridge vlan
add bridge=bridge1 tagged=ether1,bridge1 untagged=ether2 vlan-ids=10
add bridge=bridge1 tagged=ether1,bridge1 untagged=ether3 vlan-ids=20
add bridge=bridge1 tagged=ether1,bridge1 vlan-ids=99
/ip address
add address=192.168.99.11/24 interface=vlan99 network=192.168.99.0
/ip dhcp-client
add add-default-route=no interface=vlan99 use-peer-dns=no use-peer-ntp=no
/system identity
set name=SW1
/tool romon
set enabled=yes
