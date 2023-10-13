# oct/13/2023 21:49:24 by RouterOS 7.5
# software id = 
#
/interface bridge
add name=bridge vlan-filtering=yes
add name=lo1
/interface wireguard
add listen-port=13231 mtu=1420 name=wireguard1
/interface vxlan
add mac-address=96:2B:D1:71:B7:A8 name=vxlan1 port=8472 vni=1
/interface vlan
add interface=bridge name=vlan10 vlan-id=10
add interface=bridge name=vlan20 vlan-id=20
add interface=bridge name=vlan99 vlan-id=99
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=192.168.10.2-192.168.10.254
add name=dhcp_pool1 ranges=192.168.20.2-192.168.20.254
add name=dhcp_pool2 ranges=192.168.99.2-192.168.99.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=vlan10 name=dhcp1
add address-pool=dhcp_pool1 interface=vlan20 name=dhcp2
add address-pool=dhcp_pool2 interface=vlan99 name=dhcp3
/port
set 0 name=serial0
set 1 name=serial1
/interface bridge port
add bridge=bridge interface=ether2
add bridge=bridge interface=vxlan1
/interface bridge vlan
add bridge=bridge tagged=bridge,ether2,vxlan1 vlan-ids=10
add bridge=bridge tagged=bridge,ether2,vxlan1 vlan-ids=20
add bridge=bridge tagged=bridge,vxlan1,ether2 vlan-ids=99
/interface vxlan vteps
add interface=vxlan1 remote-ip=10.99.99.2
/interface wireguard peers
add allowed-address=\
    172.16.2.0/24,10.99.99.2/32,192.168.10.0/24,192.168.20.0/24 interface=\
    wireguard1 public-key="Iu48S0YHqgbvoapdpa9Y9YL2SgEptuRpcV2shd6Vv0k="
/ip address
add address=10.10.10.2/30 interface=ether1 network=10.10.10.0
add address=172.16.1.1/24 interface=lo1 network=172.16.1.0
add address=10.99.99.1/24 interface=wireguard1 network=10.99.99.0
add address=192.168.10.1/24 interface=vlan10 network=192.168.10.0
add address=192.168.20.1/24 interface=vlan20 network=192.168.20.0
add address=192.168.99.1/24 interface=vlan99 network=192.168.99.0
/ip dhcp-client
add interface=ether1
/ip dhcp-server network
add address=192.168.10.0/24 gateway=192.168.10.1
add address=192.168.20.0/24 gateway=192.168.20.1
add address=192.168.99.0/24 gateway=192.168.99.1
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
/ip route
add gateway=10.10.10.1
add disabled=no dst-address=172.16.2.0/24 gateway=10.99.99.2 routing-table=\
    main suppress-hw-offload=no
/system identity
set name=M1
/tool romon
set enabled=yes
