You are an expert in Arista AVD (Ansible Validated Designs) and EVPN/VXLAN fabric design.

Generate a complete AVD data model for a single data center EVPN/VXLAN fabric with the
following requirements:

## Topology
- 2 spine switches
- 4 leaf switches organized as 2 logical pairs (Leaf Pair 1: LEAF1A/LEAF1B,
  Leaf Pair 2: LEAF2A/LEAF2B)
- No MLAG — Active/Active multihoming is implemented via ESI-LAG (EVPN Multihoming)

## BGP Design
- Underlay: eBGP using point-to-point /31 IPv4 links
- Overlay: eBGP using loopback peering with EVPN address family
- Spine BGP ASN: 65000 (shared across both spines)
- Leaf BGP ASNs: unique per leaf node:
  - DC1-LEAF1A: 65001
  - DC1-LEAF1B: 65002
  - DC1-LEAF2A: 65003
  - DC1-LEAF2B: 65004
- Every node has a unique ASN — do not include allowas_in or any AS path manipulation

## IP Addressing
- Loopback0 pool: 192.168.100.0/24 (assigned sequentially by node ID)
- VTEP loopback pool: 192.168.101.0/24 (leaves only)
- P2P uplink pool: 10.0.0.0/24
- Management: 172.16.0.0/24
  - DC1-SPINE1: 172.16.0.11
  - DC1-SPINE2: 172.16.0.12
  - DC1-LEAF1A: 172.16.0.13
  - DC1-LEAF1B: 172.16.0.14
  - DC1-LEAF2A: 172.16.0.15
  - DC1-LEAF2B: 172.16.0.16

## EVPN/VXLAN
- Each leaf is an independent VTEP
- Active/Active multihoming using ESI-LAG with unique short_esi per dual-homed
  bundle in format XXXX:XXXX:XXXX
- Anycast gateway using ip_address_virtual on all SVIs
- Virtual router MAC: 00:1c:73:00:dc:01
- L2 VNI base: 10000 (VLAN 10 = VNI 10010, VLAN 20 = VNI 10020, VLAN 30 = VNI 10030)
- L3 VNI for PROD VRF: 1000

## Tenant / VRF / VLAN Design
- Tenant name: TENANT1
- VRF name: PROD (vrf_id: 1)
- SVIs in PROD VRF:
  - VLAN 10: ip_address_virtual 10.10.10.1/24
  - VLAN 20: ip_address_virtual 10.20.20.1/24
  - VLAN 30: ip_address_virtual 10.30.30.1/24

## AVD Schema Requirements
Follow these schema rules exactly when generating all YAML files:

1. Do NOT include a platform key in FABRIC.yml. Platform is defined only in the
   defaults block of DC1_SPINES.yml and DC1_L3LEAFS.yml as a plain quoted string:

    platform: "7050X3"

2. node_groups must be a YAML list using - group: notation:

    node_groups:
      - group: SPINES
        nodes:
          - name: DC1-SPINE1
            id: 1
            mgmt_ip: 172.16.0.11/24
          - name: DC1-SPINE2
            id: 2
            mgmt_ip: 172.16.0.12/24

3. nodes within each node_group must be a YAML list using - name: notation,
   as shown in the example above.

4. Include uplink_ipv4_pool in the l3leaf defaults block.

5. INVENTORY.yml must include a TENANTS group under DC1_FABRIC that references
   both DC1_L3LEAFS and DC1_SPINES as children:

    TENANTS:
      children:
        DC1_L3LEAFS:
        DC1_SPINES:

## Output Format
Before generating any YAML, produce a network topology diagram in ASCII art showing:
- DC1-SPINE1 and DC1-SPINE2 at the top layer
- DC1-LEAF1A, DC1-LEAF1B, DC1-LEAF2A, DC1-LEAF2B at the leaf layer
- Uplink connections from each leaf to both spines
- Each node labeled with its hostname, BGP ASN, Loopback0 IP, and VTEP loopback IP
  (spines show Loopback0 only)
- ESI-LAG dual-homed servers (SERVER1 on Leaf Pair 1, SERVER2 on Leaf Pair 2)
  shown at the bottom layer connected to their respective leaf pairs

Then produce the following AVD-structured YAML files, each clearly labeled:
1. FABRIC.yml             — fabric-wide variables (underlay/overlay protocol, BGP peer
                            groups, loopback pools, MTU). No platform key.
2. DC1_SPINES.yml         — spine node group with shared ASN 65000, both spines in a
                            single SPINES node_group using list-based schema
3. DC1_L3LEAFS.yml        — one node_group per leaf, unique BGP ASN per leaf,
                            mlag: false, list-based schema throughout
4. TENANTS.yml            — TENANT1, PROD VRF, SVIs for VLANs 10/20/30, VNI mappings
5. CONNECTED_ENDPOINTS.yml — example dual-homed server on each leaf pair using ESI-LAG,
                             unique short_esi values, LACP active mode, port profiles
                             for access (VLANs 10/20/30) and trunk
6. INVENTORY.yml          — Ansible inventory with DC1_SPINES, DC1_L3LEAFS, and TENANTS
                            groups under DC1_FABRIC, plus standard EOS connection vars

After the YAML files, provide:
- A summary table of BGP ASN and loopback assignments per node
- A summary table of VLAN, VRF, SVI gateway, L2 VNI, and L3 VNI assignments
- A bullet list of items the user should verify or customize (platform, uplink interface
  names, cabling, management VRF mode, additional ESI bundles, CloudVision integration)
