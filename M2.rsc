# oct/13/2023 21:46:11 by RouterOS 7.5
# software id = 
#
/interface bridge
add frame-types=admit-only-vlan-tagged name=bridge vlan-filtering=yes
add name=lo2
/interface wireguard
add listen-port=7978 mtu=1420 name=wireguard2
/interface vxlan
add mac-address=56:2A:8A:9A:B5:26 name=vxlan1 port=8472 vni=1
/interface vlan
add interface=bridge name=vlan10 vlan-id=10
add interface=bridge name=vlan20 vlan-id=20
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/port
set 0 name=serial0
set 1 name=serial1
/interface bridge port
add bridge=bridge interface=vxlan1
add bridge=bridge interface=ether2
/interface bridge vlan
add bridge=bridge tagged=bridge,vxlan1,ether2 vlan-ids=10
add bridge=bridge tagged=bridge,vxlan1,ether2 vlan-ids=20
add bridge=bridge tagged=bridge,ether2,vxlan1 vlan-ids=99
/interface vxlan vteps
add interface=vxlan1 remote-ip=10.99.99.1
/interface wireguard peers
add allowed-address=\
    172.16.1.0/24,10.99.99.1/32,192.168.10.0/24,192.168.20.0/24 \
    endpoint-address=10.10.10.2 endpoint-port=13231 interface=wireguard2 \
    persistent-keepalive=25s public-key=\
    "I3KhXKb+hHflnXsKtcMGoUpM35/e9aYlI828dx5O9BI="
/ip address
add address=10.10.10.6/30 interface=ether1 network=10.10.10.4
add address=172.16.2.1/24 interface=lo2 network=172.16.2.0
add address=10.99.99.2/24 interface=wireguard2 network=10.99.99.0
/ip dhcp-client
add add-default-route=no interface=vlan10 use-peer-dns=no use-peer-ntp=no
add add-default-route=no interface=vlan20 use-peer-dns=no use-peer-ntp=no
/ip route
add gateway=10.10.10.5
add disabled=no dst-address=172.16.1.0/24 gateway=10.99.99.1 routing-table=\
    main suppress-hw-offload=no
/system identity
set name=M2
/tool romon
set enabled=yes
