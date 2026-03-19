# AOC_FABRIC

## Table of Contents

- [Fabric Switches and Management IP](#fabric-switches-and-management-ip)
  - [Fabric Switches with inband Management IP](#fabric-switches-with-inband-management-ip)
- [Fabric Topology](#fabric-topology)
- [Fabric IP Allocation](#fabric-ip-allocation)
  - [Fabric Point-To-Point Links](#fabric-point-to-point-links)
  - [Point-To-Point Links Node Allocation](#point-to-point-links-node-allocation)
  - [Loopback Interfaces (BGP EVPN Peering)](#loopback-interfaces-bgp-evpn-peering)
  - [Loopback0 Interfaces Node Allocation](#loopback0-interfaces-node-allocation)
  - [VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)](#vtep-loopback-vxlan-tunnel-source-interfaces-vteps-only)
  - [VTEP Loopback Node allocation](#vtep-loopback-node-allocation)

## Fabric Switches and Management IP

| POD | Type | Node | Management IP | Platform | Provisioned in CloudVision | Serial Number |
| --- | ---- | ---- | ------------- | -------- | -------------------------- | ------------- |
| AOC_FABRIC | l3leaf | AOC-DB-1 | 192.168.0.100/24 | cEOS | Provisioned | - |
| AOC_FABRIC | l3leaf | AOC-DB-2 | 192.168.0.101/24 | cEOS | Provisioned | - |
| AOC_FABRIC | l3leaf | AOC-DL-1 | 192.168.0.14/24 | cEOS | Provisioned | - |
| AOC_FABRIC | l3leaf | AOC-DL-2 | 192.168.0.15/24 | cEOS | Provisioned | - |
| AOC_FABRIC | spine | AOC-DS-1 | 192.168.0.10/24 | cEOS | Provisioned | - |
| AOC_FABRIC | spine | AOC-DS-2 | 192.168.0.11/24 | cEOS | Provisioned | - |
| AOC_FABRIC | l3leaf | AOC-DV-1 | 192.168.0.12/24 | cEOS | Provisioned | - |
| AOC_FABRIC | l3leaf | AOC-DV-2 | 192.168.0.13/24 | cEOS | Provisioned | - |

> Provision status is based on Ansible inventory declaration and do not represent real status from CloudVision.

### Fabric Switches with inband Management IP

| POD | Type | Node | Management IP | Inband Interface |
| --- | ---- | ---- | ------------- | ---------------- |

## Fabric Topology

| Type | Node | Node Interface | Peer Type | Peer Node | Peer Interface |
| ---- | ---- | -------------- | --------- | ----------| -------------- |
| l3leaf | AOC-DB-1 | Ethernet1 | mlag_peer | AOC-DB-2 | Ethernet1 |
| l3leaf | AOC-DB-1 | Ethernet2 | spine | AOC-DS-1 | Ethernet7 |
| l3leaf | AOC-DB-1 | Ethernet3 | spine | AOC-DS-2 | Ethernet7 |
| l3leaf | AOC-DB-1 | Ethernet6 | mlag_peer | AOC-DB-2 | Ethernet6 |
| l3leaf | AOC-DB-2 | Ethernet2 | spine | AOC-DS-1 | Ethernet8 |
| l3leaf | AOC-DB-2 | Ethernet3 | spine | AOC-DS-2 | Ethernet8 |
| l3leaf | AOC-DL-1 | Ethernet1 | mlag_peer | AOC-DL-2 | Ethernet1 |
| l3leaf | AOC-DL-1 | Ethernet2 | spine | AOC-DS-1 | Ethernet4 |
| l3leaf | AOC-DL-1 | Ethernet3 | spine | AOC-DS-2 | Ethernet4 |
| l3leaf | AOC-DL-1 | Ethernet6 | mlag_peer | AOC-DL-2 | Ethernet6 |
| l3leaf | AOC-DL-2 | Ethernet2 | spine | AOC-DS-1 | Ethernet5 |
| l3leaf | AOC-DL-2 | Ethernet3 | spine | AOC-DS-2 | Ethernet5 |
| spine | AOC-DS-1 | Ethernet2 | l3leaf | AOC-DV-1 | Ethernet2 |
| spine | AOC-DS-1 | Ethernet3 | l3leaf | AOC-DV-2 | Ethernet2 |
| spine | AOC-DS-2 | Ethernet2 | l3leaf | AOC-DV-1 | Ethernet3 |
| spine | AOC-DS-2 | Ethernet3 | l3leaf | AOC-DV-2 | Ethernet3 |
| l3leaf | AOC-DV-1 | Ethernet1 | mlag_peer | AOC-DV-2 | Ethernet1 |
| l3leaf | AOC-DV-1 | Ethernet6 | mlag_peer | AOC-DV-2 | Ethernet6 |

## Fabric IP Allocation

### Fabric Point-To-Point Links

| Uplink IPv4 Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ---------------- | ------------------- | ------------------ | ------------------ |
| 172.16.1.0/24 | 256 | 24 | 9.38 % |

### Point-To-Point Links Node Allocation

| Node | Node Interface | Node IP Address | Peer Node | Peer Interface | Peer IP Address |
| ---- | -------------- | --------------- | --------- | -------------- | --------------- |
| AOC-DB-1 | Ethernet2 | 172.16.1.17/31 | AOC-DS-1 | Ethernet7 | 172.16.1.16/31 |
| AOC-DB-1 | Ethernet3 | 172.16.1.19/31 | AOC-DS-2 | Ethernet7 | 172.16.1.18/31 |
| AOC-DB-2 | Ethernet2 | 172.16.1.21/31 | AOC-DS-1 | Ethernet8 | 172.16.1.20/31 |
| AOC-DB-2 | Ethernet3 | 172.16.1.23/31 | AOC-DS-2 | Ethernet8 | 172.16.1.22/31 |
| AOC-DL-1 | Ethernet2 | 172.16.1.9/31 | AOC-DS-1 | Ethernet4 | 172.16.1.8/31 |
| AOC-DL-1 | Ethernet3 | 172.16.1.11/31 | AOC-DS-2 | Ethernet4 | 172.16.1.10/31 |
| AOC-DL-2 | Ethernet2 | 172.16.1.13/31 | AOC-DS-1 | Ethernet5 | 172.16.1.12/31 |
| AOC-DL-2 | Ethernet3 | 172.16.1.15/31 | AOC-DS-2 | Ethernet5 | 172.16.1.14/31 |
| AOC-DS-1 | Ethernet2 | 172.16.1.0/31 | AOC-DV-1 | Ethernet2 | 172.16.1.1/31 |
| AOC-DS-1 | Ethernet3 | 172.16.1.4/31 | AOC-DV-2 | Ethernet2 | 172.16.1.5/31 |
| AOC-DS-2 | Ethernet2 | 172.16.1.2/31 | AOC-DV-1 | Ethernet3 | 172.16.1.3/31 |
| AOC-DS-2 | Ethernet3 | 172.16.1.6/31 | AOC-DV-2 | Ethernet3 | 172.16.1.7/31 |

### Loopback Interfaces (BGP EVPN Peering)

| Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ------------- | ------------------- | ------------------ | ------------------ |
| 10.250.1.0/24 | 256 | 8 | 3.13 % |

### Loopback0 Interfaces Node Allocation

| POD | Node | Loopback0 |
| --- | ---- | --------- |
| AOC_FABRIC | AOC-DB-1 | 10.250.1.7/32 |
| AOC_FABRIC | AOC-DB-2 | 10.250.1.8/32 |
| AOC_FABRIC | AOC-DL-1 | 10.250.1.5/32 |
| AOC_FABRIC | AOC-DL-2 | 10.250.1.6/32 |
| AOC_FABRIC | AOC-DS-1 | 10.250.1.1/32 |
| AOC_FABRIC | AOC-DS-2 | 10.250.1.2/32 |
| AOC_FABRIC | AOC-DV-1 | 10.250.1.3/32 |
| AOC_FABRIC | AOC-DV-2 | 10.250.1.4/32 |

### VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)

| VTEP Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ------------------ | ------------------- | ------------------ | ------------------ |
| 10.255.1.0/24 | 256 | 6 | 2.35 % |

### VTEP Loopback Node allocation

| POD | Node | Loopback1 |
| --- | ---- | --------- |
| AOC_FABRIC | AOC-DB-1 | 10.255.1.7/32 |
| AOC_FABRIC | AOC-DB-2 | 10.255.1.7/32 |
| AOC_FABRIC | AOC-DL-1 | 10.255.1.5/32 |
| AOC_FABRIC | AOC-DL-2 | 10.255.1.5/32 |
| AOC_FABRIC | AOC-DV-1 | 10.255.1.3/32 |
| AOC_FABRIC | AOC-DV-2 | 10.255.1.3/32 |
