# University of Minnesota AVD Workshop

## ATD Dual Datacenter Topology

The ATD lab is used to create the L3LS EVPN/VXLAN Dual Data Center topology below.

![Topologies](images/UMN-ATD-Topology.png)

## Lap Prep

**STEP #1** - Update Lab to AVD 5.7.3

```bash
pip install "pyavd[ansible]==5.7.3"
ansible-galaxy collection install arista.avd:==5.7.3
```

**STEP #2** - Apply base configs to Lab nodes

```bash
make preplab
```

## Lab Instructions

The instructions to build and deploy this L3LS Multi-site topology are located in the Lab Guide **[here](https://labguides.testdrive.arista.com/2025.3/automation/ci_avd_l3ls/overview/)**.
