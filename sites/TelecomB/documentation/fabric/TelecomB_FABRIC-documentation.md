# TelecomB_FABRIC

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
| TelecomB_FABRIC | l3leaf | TelecomB-DB-1 | 192.168.0.200/24 | cEOS | Provisioned | - |
| TelecomB_FABRIC | l3leaf | TelecomB-DB-2 | 192.168.0.201/24 | cEOS | Provisioned | - |
| TelecomB_FABRIC | l3leaf | TelecomB-DL-1 | 192.168.0.24/24 | cEOS | Provisioned | - |
| TelecomB_FABRIC | l3leaf | TelecomB-DL-2 | 192.168.0.25/24 | cEOS | Provisioned | - |
| TelecomB_FABRIC | spine | TelecomB-DS-1 | 192.168.0.20/24 | cEOS | Provisioned | - |
| TelecomB_FABRIC | spine | TelecomB-DS-2 | 192.168.0.21/24 | cEOS | Provisioned | - |
| TelecomB_FABRIC | l3leaf | TelecomB-DV-1 | 192.168.0.22/24 | cEOS | Provisioned | - |
| TelecomB_FABRIC | l3leaf | TelecomB-DV-2 | 192.168.0.23/24 | cEOS | Provisioned | - |

> Provision status is based on Ansible inventory declaration and do not represent real status from CloudVision.

### Fabric Switches with inband Management IP

| POD | Type | Node | Management IP | Inband Interface |
| --- | ---- | ---- | ------------- | ---------------- |

## Fabric Topology

| Type | Node | Node Interface | Peer Type | Peer Node | Peer Interface |
| ---- | ---- | -------------- | --------- | ----------| -------------- |
| l3leaf | TelecomB-DB-1 | Ethernet1 | mlag_peer | TelecomB-DB-2 | Ethernet1 |
| l3leaf | TelecomB-DB-1 | Ethernet2 | spine | TelecomB-DS-1 | Ethernet7 |
| l3leaf | TelecomB-DB-1 | Ethernet3 | spine | TelecomB-DS-2 | Ethernet7 |
| l3leaf | TelecomB-DB-1 | Ethernet6 | mlag_peer | TelecomB-DB-2 | Ethernet6 |
| l3leaf | TelecomB-DB-2 | Ethernet2 | spine | TelecomB-DS-1 | Ethernet8 |
| l3leaf | TelecomB-DB-2 | Ethernet3 | spine | TelecomB-DS-2 | Ethernet8 |
| l3leaf | TelecomB-DL-1 | Ethernet1 | mlag_peer | TelecomB-DL-2 | Ethernet1 |
| l3leaf | TelecomB-DL-1 | Ethernet2 | spine | TelecomB-DS-1 | Ethernet4 |
| l3leaf | TelecomB-DL-1 | Ethernet3 | spine | TelecomB-DS-2 | Ethernet4 |
| l3leaf | TelecomB-DL-1 | Ethernet6 | mlag_peer | TelecomB-DL-2 | Ethernet6 |
| l3leaf | TelecomB-DL-2 | Ethernet2 | spine | TelecomB-DS-1 | Ethernet5 |
| l3leaf | TelecomB-DL-2 | Ethernet3 | spine | TelecomB-DS-2 | Ethernet5 |
| spine | TelecomB-DS-1 | Ethernet2 | l3leaf | TelecomB-DV-1 | Ethernet2 |
| spine | TelecomB-DS-1 | Ethernet3 | l3leaf | TelecomB-DV-2 | Ethernet2 |
| spine | TelecomB-DS-2 | Ethernet2 | l3leaf | TelecomB-DV-1 | Ethernet3 |
| spine | TelecomB-DS-2 | Ethernet3 | l3leaf | TelecomB-DV-2 | Ethernet3 |
| l3leaf | TelecomB-DV-1 | Ethernet1 | mlag_peer | TelecomB-DV-2 | Ethernet1 |
| l3leaf | TelecomB-DV-1 | Ethernet6 | mlag_peer | TelecomB-DV-2 | Ethernet6 |

## Fabric IP Allocation

### Fabric Point-To-Point Links

| Uplink IPv4 Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ---------------- | ------------------- | ------------------ | ------------------ |
| 172.16.2.0/24 | 256 | 24 | 9.38 % |

### Point-To-Point Links Node Allocation

| Node | Node Interface | Node IP Address | Peer Node | Peer Interface | Peer IP Address |
| ---- | -------------- | --------------- | --------- | -------------- | --------------- |
| TelecomB-DB-1 | Ethernet2 | 172.16.2.17/31 | TelecomB-DS-1 | Ethernet7 | 172.16.2.16/31 |
| TelecomB-DB-1 | Ethernet3 | 172.16.2.19/31 | TelecomB-DS-2 | Ethernet7 | 172.16.2.18/31 |
| TelecomB-DB-2 | Ethernet2 | 172.16.2.21/31 | TelecomB-DS-1 | Ethernet8 | 172.16.2.20/31 |
| TelecomB-DB-2 | Ethernet3 | 172.16.2.23/31 | TelecomB-DS-2 | Ethernet8 | 172.16.2.22/31 |
| TelecomB-DL-1 | Ethernet2 | 172.16.2.9/31 | TelecomB-DS-1 | Ethernet4 | 172.16.2.8/31 |
| TelecomB-DL-1 | Ethernet3 | 172.16.2.11/31 | TelecomB-DS-2 | Ethernet4 | 172.16.2.10/31 |
| TelecomB-DL-2 | Ethernet2 | 172.16.2.13/31 | TelecomB-DS-1 | Ethernet5 | 172.16.2.12/31 |
| TelecomB-DL-2 | Ethernet3 | 172.16.2.15/31 | TelecomB-DS-2 | Ethernet5 | 172.16.2.14/31 |
| TelecomB-DS-1 | Ethernet2 | 172.16.2.0/31 | TelecomB-DV-1 | Ethernet2 | 172.16.2.1/31 |
| TelecomB-DS-1 | Ethernet3 | 172.16.2.4/31 | TelecomB-DV-2 | Ethernet2 | 172.16.2.5/31 |
| TelecomB-DS-2 | Ethernet2 | 172.16.2.2/31 | TelecomB-DV-1 | Ethernet3 | 172.16.2.3/31 |
| TelecomB-DS-2 | Ethernet3 | 172.16.2.6/31 | TelecomB-DV-2 | Ethernet3 | 172.16.2.7/31 |

### Loopback Interfaces (BGP EVPN Peering)

| Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ------------- | ------------------- | ------------------ | ------------------ |
| 10.250.2.0/24 | 256 | 8 | 3.13 % |

### Loopback0 Interfaces Node Allocation

| POD | Node | Loopback0 |
| --- | ---- | --------- |
| TelecomB_FABRIC | TelecomB-DB-1 | 10.250.2.7/32 |
| TelecomB_FABRIC | TelecomB-DB-2 | 10.250.2.8/32 |
| TelecomB_FABRIC | TelecomB-DL-1 | 10.250.2.5/32 |
| TelecomB_FABRIC | TelecomB-DL-2 | 10.250.2.6/32 |
| TelecomB_FABRIC | TelecomB-DS-1 | 10.250.2.1/32 |
| TelecomB_FABRIC | TelecomB-DS-2 | 10.250.2.2/32 |
| TelecomB_FABRIC | TelecomB-DV-1 | 10.250.2.3/32 |
| TelecomB_FABRIC | TelecomB-DV-2 | 10.250.2.4/32 |

### VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)

| VTEP Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ------------------ | ------------------- | ------------------ | ------------------ |
| 10.255.2.0/24 | 256 | 6 | 2.35 % |

### VTEP Loopback Node allocation

| POD | Node | Loopback1 |
| --- | ---- | --------- |
| TelecomB_FABRIC | TelecomB-DB-1 | 10.255.2.7/32 |
| TelecomB_FABRIC | TelecomB-DB-2 | 10.255.2.7/32 |
| TelecomB_FABRIC | TelecomB-DL-1 | 10.255.2.5/32 |
| TelecomB_FABRIC | TelecomB-DL-2 | 10.255.2.5/32 |
| TelecomB_FABRIC | TelecomB-DV-1 | 10.255.2.3/32 |
| TelecomB_FABRIC | TelecomB-DV-2 | 10.255.2.3/32 |
