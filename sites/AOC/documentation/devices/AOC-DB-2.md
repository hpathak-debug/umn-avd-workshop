# AOC-DB-2

## Table of Contents

- [Management](#management)
  - [Management Interfaces](#management-interfaces)
  - [DNS Domain](#dns-domain)
  - [IP Name Servers](#ip-name-servers)
  - [Domain Lookup](#domain-lookup)
  - [NTP](#ntp)
  - [Management API HTTP](#management-api-http)
- [Authentication](#authentication)
  - [Local Users](#local-users)
  - [Enable Password](#enable-password)
  - [AAA Authorization](#aaa-authorization)
- [Monitoring](#monitoring)
  - [TerminAttr Daemon](#terminattr-daemon)
- [Spanning Tree](#spanning-tree)
  - [Spanning Tree Summary](#spanning-tree-summary)
  - [Spanning Tree Device Configuration](#spanning-tree-device-configuration)
- [Internal VLAN Allocation Policy](#internal-vlan-allocation-policy)
  - [Internal VLAN Allocation Policy Summary](#internal-vlan-allocation-policy-summary)
  - [Internal VLAN Allocation Policy Device Configuration](#internal-vlan-allocation-policy-device-configuration)
- [VLANs](#vlans)
  - [VLANs Summary](#vlans-summary)
  - [VLANs Device Configuration](#vlans-device-configuration)
- [Interfaces](#interfaces)
  - [Ethernet Interfaces](#ethernet-interfaces)
  - [Loopback Interfaces](#loopback-interfaces)
  - [VLAN Interfaces](#vlan-interfaces)
  - [VXLAN Interface](#vxlan-interface)
- [Routing](#routing)
  - [Service Routing Protocols Model](#service-routing-protocols-model)
  - [Virtual Router MAC Address](#virtual-router-mac-address)
  - [IP Routing](#ip-routing)
  - [IPv6 Routing](#ipv6-routing)
  - [Static Routes](#static-routes)
  - [Router BGP](#router-bgp)
- [BFD](#bfd)
  - [Router BFD](#router-bfd)
- [Multicast](#multicast)
  - [IP IGMP Snooping](#ip-igmp-snooping)
- [Filters](#filters)
  - [Prefix-lists](#prefix-lists)
  - [Route-maps](#route-maps)
- [VRF Instances](#vrf-instances)
  - [VRF Instances Summary](#vrf-instances-summary)
  - [VRF Instances Device Configuration](#vrf-instances-device-configuration)

## Management

### Management Interfaces

#### Management Interfaces Summary

##### IPv4

| Management Interface | Description | Type | VRF | IP Address | Gateway |
| -------------------- | ----------- | ---- | --- | ---------- | ------- |
| Management0 | OOB_MANAGEMENT | oob | default | 192.168.0.101/24 | 192.168.0.1 |

##### IPv6

| Management Interface | Description | Type | VRF | IPv6 Address | IPv6 Gateway |
| -------------------- | ----------- | ---- | --- | ------------ | ------------ |
| Management0 | OOB_MANAGEMENT | oob | default | - | - |

#### Management Interfaces Device Configuration

```eos
!
interface Management0
   description OOB_MANAGEMENT
   no shutdown
   ip address 192.168.0.101/24
```

### DNS Domain

DNS domain: atd.lab

#### DNS Domain Device Configuration

```eos
dns domain atd.lab
!
```

### IP Name Servers

#### IP Name Servers Summary

| Name Server | VRF | Priority |
| ----------- | --- | -------- |
| 192.168.0.1 | default | - |

#### IP Name Servers Device Configuration

```eos
ip name-server vrf default 192.168.0.1
```

### Domain Lookup

#### DNS Domain Lookup Summary

| Source interface | vrf |
| ---------------- | --- |
| Management0 | - |

#### DNS Domain Lookup Device Configuration

```eos
ip domain lookup source-interface Management0
```

### NTP

#### NTP Summary

##### NTP Local Interface

| Interface | VRF |
| --------- | --- |
| Management0 | default |

##### NTP Servers

| Server | VRF | Preferred | Burst | iBurst | Version | Min Poll | Max Poll | Local-interface | Key |
| ------ | --- | --------- | ----- | ------ | ------- | -------- | -------- | --------------- | --- |
| 192.168.0.1 | default | True | - | True | - | - | - | - | - |

#### NTP Device Configuration

```eos
!
ntp local-interface Management0
ntp server 192.168.0.1 prefer iburst
```

### Management API HTTP

#### Management API HTTP Summary

| HTTP | HTTPS | UNIX-Socket | Default Services |
| ---- | ----- | ----------- | ---------------- |
| False | True | - | - |

#### Management API VRF Access

| VRF Name | IPv4 ACL | IPv6 ACL |
| -------- | -------- | -------- |
| default | - | - |

#### Management API HTTP Device Configuration

```eos
!
management api http-commands
   protocol https
   no shutdown
   !
   vrf default
      no shutdown
```

## Authentication

### Local Users

#### Local Users Summary

| User | Privilege | Role | Disabled | Shell |
| ---- | --------- | ---- | -------- | ----- |
| arista | 15 | network-admin | False | - |

#### Local Users Device Configuration

```eos
!
username arista privilege 15 role network-admin secret sha512 <removed>
username arista ssh-key ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2IF3/7Ez4F5v2V0c0RUJc70ScbrlxRROhFvjDGIaBto5dOuclyZCgFVU+hwpWqNXRGd3+5s9JpYH7Y8hqH7onV8Q7L7gIJyB1DWtY6DI5KoDDGCVdDJTTDMw4Z5sO4KDXfWNYdvJMjhmBQXgTofC+1oZiWBX3Xrwwn6Vz+OmV6CG6+8YoZ21+p4PcOvTg4n2IzAH9L7hIdTtDGVk84A99U44Z8JGO+iGalf8Voev4Qd44PQPwbrY6o0Qom6GuLBuz3q+W6OYudIR+4HAmbNH9SLg/Ybcnz3GFyPVqGScY3olo+lwyeEwbz2K+8v9Yi9caGtEOBkC4rRkGPnh89gvd arista@umn-2-1-ad5a6f69-eos
```

### Enable Password

Enable password has been disabled

### AAA Authorization

#### AAA Authorization Summary

| Type | User Stores |
| ---- | ----------- |
| Exec | local |

Authorization for configuration commands is disabled.

#### AAA Authorization Device Configuration

```eos
aaa authorization exec default local
!
```

## Monitoring

### TerminAttr Daemon

#### TerminAttr Daemon Summary

| CV Compression | CloudVision Servers | VRF | Authentication | Smash Excludes | Ingest Exclude | Bypass AAA |
| -------------- | ------------------- | --- | -------------- | -------------- | -------------- | ---------- |
| gzip | 192.168.0.5:9910 | default | token,/tmp/token | ale,flexCounter,hardware,kni,pulse,strata | - | True |

#### TerminAttr Daemon Device Configuration

```eos
!
daemon TerminAttr
   exec /usr/bin/TerminAttr -cvaddr=192.168.0.5:9910 -cvauth=token,/tmp/token -cvvrf=default -disableaaa -smashexcludes=ale,flexCounter,hardware,kni,pulse,strata -taillogs -cvsourceintf=Management0
   no shutdown
```

## Spanning Tree

### Spanning Tree Summary

STP mode: **mstp**

#### MSTP Instance and Priority

| Instance(s) | Priority |
| -------- | -------- |
| 0 | 32768 |

### Spanning Tree Device Configuration

```eos
!
spanning-tree mode mstp
spanning-tree mst 0 priority 32768
```

## Internal VLAN Allocation Policy

### Internal VLAN Allocation Policy Summary

| Policy Allocation | Range Beginning | Range Ending |
| ------------------| --------------- | ------------ |
| ascending | 1006 | 1199 |

### Internal VLAN Allocation Policy Device Configuration

```eos
!
vlan internal order ascending range 1006 1199
```

## VLANs

### VLANs Summary

| VLAN ID | Name | Trunk Groups |
| ------- | ---- | ------------ |
| 10 | Ten | - |
| 20 | Twenty | - |
| 30 | Thirty | - |
| 40 | Forty | - |

### VLANs Device Configuration

```eos
!
vlan 10
   name Ten
!
vlan 20
   name Twenty
!
vlan 30
   name Thirty
!
vlan 40
   name Forty
```

## Interfaces

### Ethernet Interfaces

#### Ethernet Interfaces Summary

##### L2

| Interface | Description | Mode | VLANs | Native VLAN | Trunk Group | Channel-Group |
| --------- | ----------- | ---- | ----- | ----------- | ----------- | ------------- |

*Inherited from Port-Channel Interface

##### IPv4

| Interface | Description | Channel Group | IP Address | VRF |  MTU | Shutdown | ACL In | ACL Out |
| --------- | ----------- | ------------- | ---------- | ----| ---- | -------- | ------ | ------- |
| Ethernet2 | P2P_AOC-DS-1_Ethernet8 | - | 172.16.1.21/31 | default | 1500 | False | - | - |
| Ethernet3 | P2P_AOC-DS-2_Ethernet8 | - | 172.16.1.23/31 | default | 1500 | False | - | - |
| Ethernet5 | P2P_TelecomB-DB-2_Ethernet5 | - | 172.16.255.2/31 | default | 1500 | False | - | - |

#### Ethernet Interfaces Device Configuration

```eos
!
interface Ethernet2
   description P2P_AOC-DS-1_Ethernet8
   no shutdown
   mtu 1500
   no switchport
   ip address 172.16.1.21/31
!
interface Ethernet3
   description P2P_AOC-DS-2_Ethernet8
   no shutdown
   mtu 1500
   no switchport
   ip address 172.16.1.23/31
!
interface Ethernet5
   description P2P_TelecomB-DB-2_Ethernet5
   no shutdown
   mtu 1500
   no switchport
   ip address 172.16.255.2/31
```

### Loopback Interfaces

#### Loopback Interfaces Summary

##### IPv4

| Interface | Description | VRF | IP Address |
| --------- | ----------- | --- | ---------- |
| Loopback0 | ROUTER_ID | default | 10.250.1.6/32 |
| Loopback1 | VXLAN_TUNNEL_SOURCE | default | 10.255.1.6/32 |

##### IPv6

| Interface | Description | VRF | IPv6 Address |
| --------- | ----------- | --- | ------------ |
| Loopback0 | ROUTER_ID | default | - |
| Loopback1 | VXLAN_TUNNEL_SOURCE | default | - |

#### Loopback Interfaces Device Configuration

```eos
!
interface Loopback0
   description ROUTER_ID
   no shutdown
   ip address 10.250.1.6/32
!
interface Loopback1
   description VXLAN_TUNNEL_SOURCE
   no shutdown
   ip address 10.255.1.6/32
```

### VLAN Interfaces

#### VLAN Interfaces Summary

| Interface | Description | VRF |  MTU | Shutdown |
| --------- | ----------- | --- | ---- | -------- |
| Vlan10 | Ten | PROD | - | False |
| Vlan20 | Twenty | PROD | - | False |
| Vlan30 | Thirty | PROD | - | False |
| Vlan40 | Forty | PROD | - | False |

##### IPv4

| Interface | VRF | IP Address | IP Address Virtual | IP Router Virtual Address | ACL In | ACL Out |
| --------- | --- | ---------- | ------------------ | ------------------------- | ------ | ------- |
| Vlan10 |  PROD  |  -  |  10.10.10.1/24  |  -  |  -  |  -  |
| Vlan20 |  PROD  |  -  |  10.20.20.1/24  |  -  |  -  |  -  |
| Vlan30 |  PROD  |  -  |  10.30.30.1/24  |  -  |  -  |  -  |
| Vlan40 |  PROD  |  -  |  10.40.40.1/24  |  -  |  -  |  -  |

#### VLAN Interfaces Device Configuration

```eos
!
interface Vlan10
   description Ten
   no shutdown
   vrf PROD
   ip address virtual 10.10.10.1/24
!
interface Vlan20
   description Twenty
   no shutdown
   vrf PROD
   ip address virtual 10.20.20.1/24
!
interface Vlan30
   description Thirty
   no shutdown
   vrf PROD
   ip address virtual 10.30.30.1/24
!
interface Vlan40
   description Forty
   no shutdown
   vrf PROD
   ip address virtual 10.40.40.1/24
```

### VXLAN Interface

#### VXLAN Interface Summary

| Setting | Value |
| ------- | ----- |
| Source Interface | Loopback1 |
| UDP port | 4789 |

##### VLAN to VNI, Flood List and Multicast Group Mappings

| VLAN | VNI | Flood List | Multicast Group |
| ---- | --- | ---------- | --------------- |
| 10 | 10010 | - | - |
| 20 | 10020 | - | - |
| 30 | 10030 | - | - |
| 40 | 10040 | - | - |

##### VRF to VNI and Multicast Group Mappings

| VRF | VNI | Overlay Multicast Group to Encap Mappings |
| --- | --- | ----------------------------------------- |
| PROD | 50001 | - |

#### VXLAN Interface Device Configuration

```eos
!
interface Vxlan1
   description AOC-DB-2_VTEP
   vxlan source-interface Loopback1
   vxlan udp-port 4789
   vxlan vlan 10 vni 10010
   vxlan vlan 20 vni 10020
   vxlan vlan 30 vni 10030
   vxlan vlan 40 vni 10040
   vxlan vrf PROD vni 50001
```

## Routing

### Service Routing Protocols Model

Multi agent routing protocol model enabled

```eos
!
service routing protocols model multi-agent
```

### Virtual Router MAC Address

#### Virtual Router MAC Address Summary

Virtual Router MAC Address: 00:1c:73:00:00:99

#### Virtual Router MAC Address Device Configuration

```eos
!
ip virtual-router mac-address 00:1c:73:00:00:99
```

### IP Routing

#### IP Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | True |
| PROD | True |

#### IP Routing Device Configuration

```eos
!
ip routing
ip routing vrf PROD
```

### IPv6 Routing

#### IPv6 Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | False |
| default | false |
| PROD | false |

### Static Routes

#### Static Routes Summary

| VRF | Destination Prefix | Next Hop IP | Exit interface | Administrative Distance | Tag | Route Name | Metric |
| --- | ------------------ | ----------- | -------------- | ----------------------- | --- | ---------- | ------ |
| default | 0.0.0.0/0 | 192.168.0.1 | - | 1 | - | - | - |

#### Static Routes Device Configuration

```eos
!
ip route 0.0.0.0/0 192.168.0.1
```

### Router BGP

ASN Notation: asplain

#### Router BGP Summary

| BGP AS | Router ID |
| ------ | --------- |
| 65106 | 10.250.1.6 |

| BGP Tuning |
| ---------- |
| bgp bestpath d-path |
| no bgp default ipv4-unicast |
| maximum-paths 4 ecmp 4 |

#### Router BGP Peer Groups

##### EVPN-OVERLAY-CORE

| Settings | Value |
| -------- | ----- |
| Address Family | evpn |
| Source | Loopback0 |
| BFD | True |
| Ebgp multihop | 15 |
| Send community | all |
| Maximum routes | 0 (no limit) |

##### EVPN-OVERLAY-PEERS

| Settings | Value |
| -------- | ----- |
| Address Family | evpn |
| Source | Loopback0 |
| BFD | True |
| Ebgp multihop | 3 |
| Send community | all |
| Maximum routes | 0 (no limit) |

##### IPv4-UNDERLAY-PEERS

| Settings | Value |
| -------- | ----- |
| Address Family | ipv4 |
| Send community | all |
| Maximum routes | 12000 |

#### BGP Neighbors

| Neighbor | Remote AS | VRF | Shutdown | Send-community | Maximum-routes | Allowas-in | BFD | RIB Pre-Policy Retain | Route-Reflector Client | Passive | TTL Max Hops |
| -------- | --------- | --- | -------- | -------------- | -------------- | ---------- | --- | --------------------- | ---------------------- | ------- | ------------ |
| 10.250.1.101 | 65100 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - |
| 10.250.1.102 | 65100 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - |
| 10.250.2.6 | 65206 | default | - | Inherited from peer group EVPN-OVERLAY-CORE | Inherited from peer group EVPN-OVERLAY-CORE | - | Inherited from peer group EVPN-OVERLAY-CORE | - | - | - | - |
| 172.16.1.20 | 65100 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - |
| 172.16.1.22 | 65100 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - |
| 172.16.255.3 | 65206 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - |

#### Router BGP EVPN Address Family

- VPN import pruning is **enabled**

##### EVPN Peer Groups

| Peer Group | Activate | Route-map In | Route-map Out | Peer-tag In | Peer-tag Out | Encapsulation | Next-hop-self Source Interface |
| ---------- | -------- | ------------ | ------------- | ----------- | ------------ | ------------- | ------------------------------ |
| EVPN-OVERLAY-CORE | True | - | - | - | - | default | - |
| EVPN-OVERLAY-PEERS | True | - | - | - | - | default | - |

##### EVPN DCI Gateway Summary

| Settings | Value |
| -------- | ----- |
| Local Domain | 1:1 |
| Remote Domain | 2:2 |
| Remote Domain Peer Groups | EVPN-OVERLAY-CORE |
| Local Domain: Ethernet-Segment Identifier | 000a:aaaa:aaaa:1111:1111 |
| Local Domain: Ethernet-Segment import Route-Target | aa:aa:aa:11:11:11 |
| Remote Domain: Ethernet-Segment Identifier | 000a:aaaa:aaaa:2222:2222 |
| Remote Domain: Ethernet-Segment import Route-Target | aa:aa:aa:22:22:22 |

#### Router BGP VLANs

| VLAN | Route-Distinguisher | Both Route-Target | Import Route Target | Export Route-Target | Redistribute |
| ---- | ------------------- | ----------------- | ------------------- | ------------------- | ------------ |
| 10 | 10.250.1.6:10010 | 10010:10010<br>remote 10010:10010 | - | - | learned |
| 20 | 10.250.1.6:10020 | 10020:10020<br>remote 10020:10020 | - | - | learned |
| 30 | 10.250.1.6:10030 | 10030:10030<br>remote 10030:10030 | - | - | learned |
| 40 | 10.250.1.6:10040 | 10040:10040<br>remote 10040:10040 | - | - | learned |

#### Router BGP VRFs

| VRF | Route-Distinguisher | Redistribute | Graceful Restart |
| --- | ------------------- | ------------ | ---------------- |
| PROD | evpn domain all 10.250.1.6:50001 | connected | - |

#### Router BGP Device Configuration

```eos
!
router bgp 65106
   router-id 10.250.1.6
   no bgp default ipv4-unicast
   maximum-paths 4 ecmp 4
   bgp bestpath d-path
   neighbor EVPN-OVERLAY-CORE peer group
   neighbor EVPN-OVERLAY-CORE update-source Loopback0
   neighbor EVPN-OVERLAY-CORE bfd
   neighbor EVPN-OVERLAY-CORE ebgp-multihop 15
   neighbor EVPN-OVERLAY-CORE send-community
   neighbor EVPN-OVERLAY-CORE maximum-routes 0
   neighbor EVPN-OVERLAY-PEERS peer group
   neighbor EVPN-OVERLAY-PEERS update-source Loopback0
   neighbor EVPN-OVERLAY-PEERS bfd
   neighbor EVPN-OVERLAY-PEERS ebgp-multihop 3
   neighbor EVPN-OVERLAY-PEERS password 7 <removed>
   neighbor EVPN-OVERLAY-PEERS send-community
   neighbor EVPN-OVERLAY-PEERS maximum-routes 0
   neighbor IPv4-UNDERLAY-PEERS peer group
   neighbor IPv4-UNDERLAY-PEERS password 7 <removed>
   neighbor IPv4-UNDERLAY-PEERS send-community
   neighbor IPv4-UNDERLAY-PEERS maximum-routes 12000
   neighbor 10.250.1.101 peer group EVPN-OVERLAY-PEERS
   neighbor 10.250.1.101 remote-as 65100
   neighbor 10.250.1.101 description AOC-DS-1_Loopback0
   neighbor 10.250.1.102 peer group EVPN-OVERLAY-PEERS
   neighbor 10.250.1.102 remote-as 65100
   neighbor 10.250.1.102 description AOC-DS-2_Loopback0
   neighbor 10.250.2.6 peer group EVPN-OVERLAY-CORE
   neighbor 10.250.2.6 remote-as 65206
   neighbor 10.250.2.6 description TelecomB-DB-2
   neighbor 172.16.1.20 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.16.1.20 remote-as 65100
   neighbor 172.16.1.20 description AOC-DS-1_Ethernet8
   neighbor 172.16.1.22 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.16.1.22 remote-as 65100
   neighbor 172.16.1.22 description AOC-DS-2_Ethernet8
   neighbor 172.16.255.3 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.16.255.3 remote-as 65206
   neighbor 172.16.255.3 description TelecomB-DB-2
   redistribute connected route-map RM-CONN-2-BGP
   !
   vlan 10
      rd 10.250.1.6:10010
      rd evpn domain remote 10.250.1.6:10010
      route-target both 10010:10010
      route-target import export evpn domain remote 10010:10010
      redistribute learned
   !
   vlan 20
      rd 10.250.1.6:10020
      rd evpn domain remote 10.250.1.6:10020
      route-target both 10020:10020
      route-target import export evpn domain remote 10020:10020
      redistribute learned
   !
   vlan 30
      rd 10.250.1.6:10030
      rd evpn domain remote 10.250.1.6:10030
      route-target both 10030:10030
      route-target import export evpn domain remote 10030:10030
      redistribute learned
   !
   vlan 40
      rd 10.250.1.6:10040
      rd evpn domain remote 10.250.1.6:10040
      route-target both 10040:10040
      route-target import export evpn domain remote 10040:10040
      redistribute learned
   !
   address-family evpn
      neighbor EVPN-OVERLAY-CORE activate
      neighbor EVPN-OVERLAY-CORE domain remote
      neighbor EVPN-OVERLAY-PEERS activate
      domain identifier 1:1
      domain identifier 2:2 remote
      route import match-failure action discard
      !
      evpn ethernet-segment domain local
         identifier 000a:aaaa:aaaa:1111:1111
         route-target import aa:aa:aa:11:11:11
      !
      evpn ethernet-segment domain remote
         identifier 000a:aaaa:aaaa:2222:2222
         route-target import aa:aa:aa:22:22:22
   !
   address-family ipv4
      no neighbor EVPN-OVERLAY-CORE activate
      no neighbor EVPN-OVERLAY-PEERS activate
      neighbor IPv4-UNDERLAY-PEERS activate
   !
   vrf PROD
      rd evpn domain all 10.250.1.6:50001
      route-target import evpn 50001:50001
      route-target import evpn domain all 50001:50001
      route-target export evpn 50001:50001
      route-target export evpn domain all 50001:50001
      router-id 10.250.1.6
      redistribute connected
```

## BFD

### Router BFD

#### Router BFD Multihop Summary

| Interval | Minimum RX | Multiplier |
| -------- | ---------- | ---------- |
| 300 | 300 | 3 |

#### Router BFD Device Configuration

```eos
!
router bfd
   multihop interval 300 min-rx 300 multiplier 3
```

## Multicast

### IP IGMP Snooping

#### IP IGMP Snooping Summary

| IGMP Snooping | Fast Leave | Interface Restart Query | Proxy | Restart Query Interval | Robustness Variable |
| ------------- | ---------- | ----------------------- | ----- | ---------------------- | ------------------- |
| Enabled | - | - | - | - | - |

#### IP IGMP Snooping Device Configuration

```eos
```

## Filters

### Prefix-lists

#### Prefix-lists Summary

##### PL-LOOPBACKS-EVPN-OVERLAY

| Sequence | Action |
| -------- | ------ |
| 10 | permit 10.250.1.0/24 eq 32 |
| 20 | permit 10.255.1.0/24 eq 32 |

#### Prefix-lists Device Configuration

```eos
!
ip prefix-list PL-LOOPBACKS-EVPN-OVERLAY
   seq 10 permit 10.250.1.0/24 eq 32
   seq 20 permit 10.255.1.0/24 eq 32
```

### Route-maps

#### Route-maps Summary

##### RM-CONN-2-BGP

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | permit | ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY | - | - | - |

#### Route-maps Device Configuration

```eos
!
route-map RM-CONN-2-BGP permit 10
   match ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY
```

## VRF Instances

### VRF Instances Summary

| VRF Name | IP Routing |
| -------- | ---------- |
| PROD | enabled |

### VRF Instances Device Configuration

```eos
!
vrf instance PROD
```
