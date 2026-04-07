# University of Minnesota AVD Workshop

## ATD Dual Datacenter Topology - MLAG Multihoming

The ATD lab is used to create the L3LS EVPN/VXLAN Dual Data Center topology below.

![Topologies](images/UMN-ATD-Topology.png)

## Lap Prep - Customized for UoMN Workshop

**STEP #1 - Fork Repository**

In GitHub, fork the following [repository](https://github.com/mthiel117/umn-avd-workshop.git).


**STEP #2 - Clone Forked Repository to Lab environment**

Replace xxxxxxxxx with your github path.

```bash
cd labfiles
git clone https://github.com/xxxxxxxxxx/umn-avd-workshop.git
```

**STEP #3 - Add Git Settings**

Setup Git config with your username and email.  This is needed for Git commits and logs.

```bash
git config --global user.name "FirstName LastName"
git config --global user.email "name@example.com"
```

**STEP #4 - Update Lab to AVD 5.7.3**

```bash
pip install "pyavd[ansible]==5.7.3"
ansible-galaxy collection install arista.avd:==5.7.3

# Verify AVD version
ansible-galaxy collection list
```

**STEP #5 - Reset nodes to undefined container in CVP** - ***IMPORTANT: Verify CVP is running before executing this command***

```bash
make reset_to_undefined
```

**STEP #6 - Apply base configs to Lab nodes**

Applies base configs and changes the hostnames to match custom lab for UMN.

```bash
make preplab
```

**STEP #7 - Export CVP Service Account token to env variable CV_TOKEN**

If you wish to push configuration to nodes with CVP, you will need to create a Service Account Token and insert it below.

Follow the instructions on the [CloudVison documentation website](https://www.arista.io/help/2024.3/articles/c2V0dGluZ3MuQWxsLmFjY2Vzc0NvbnRyb2wuc2VydmljZUFjY291bnRz#service-accounts) to create a Service Account and generate a Service Account Token. The token is used to connect to the CloudVision APIs when using the arista.avd.cv_deploy role.

```bash
export CV_TOKEN=<insert token>
```

## Follow the Lab Guide Instructions

Go back to [Lab Guide](https://labguides.testdrive.arista.com/2025.3/automation/ci_avd_l3ls/day0/#step-1-prepare-lab-environment) - Step 2 - Deployment Overview


***Note:***

While the documentation references Site1 and Site2, our custom lab environment will use the following mappings:

- Site1 ---> AOC
- Site2 ---> TelecomB



## Hostname Mappings

| Original Hostname | Lab Hostname      | Management0   |
|-------------------|-------------------|---------------|
| s1-brdr1          | AOC-DB-1          | 192.168.0.100 |
| s1-brdr2          | AOC-DB-2          | 192.168.0.101 |
| s1-core1          | AOC-CORE-1        | 192.168.0.102 |
| s1-core2          | AOC-CORE-2        | 192.168.0.103 |
| s1-host1          | AOC-HOST-1        | 192.168.0.16  |
| s1-host2          | AOC-HOST-2        | 192.168.0.17  |
| s1-leaf1          | AOC-DV-1          | 192.168.0.12  |
| s1-leaf2          | AOC-DV-2          | 192.168.0.13  |
| s1-leaf3          | AOC-DL-1          | 192.168.0.14  |
| s1-leaf4          | AOC-DL-2          | 192.168.0.15  |
| s1-spine1         | AOC-DS-1          | 192.168.0.10  |
| s1-spine2         | AOC-DS-2          | 192.168.0.11  |
| s2-brdr1          | TelecomB-DB-1     | 192.168.0.200 |
| s2-brdr2          | TelecomB-DB-2     | 192.168.0.201 |
| s2-core1          | TelecomB-CORE-1   | 192.168.0.202 |
| s2-core2          | TelecomB-CORE-2   | 192.168.0.203 |
| s2-host1          | TelecomB-HOST-1   | 192.168.0.26  |
| s2-host2          | TelecomB-HOST-2   | 192.168.0.27  |
| s2-leaf1          | TelecomB-DV-1     | 192.168.0.22  |
| s2-leaf2          | TelecomB-DV-2     | 192.168.0.23  |
| s2-leaf3          | TelecomB-DL-1     | 192.168.0.24  |
| s2-leaf4          | TelecomB-DL-2     | 192.168.0.25  |
| s2-spine1         | TelecomB-DS-1     | 192.168.0.20  |
| s2-spine2         | TelecomB-DS-2     | 192.168.0.21  |


## Make Commands - Build and Deploy AOC Fabric Configs

```bash
# Build AOC Fabric Configs
make AOC-build

# Deploy AOC Fabric Configs via CVP
make AOC-CVP-deploy

# Deploy AOC Fabric Configs via eAPI (direct to switches)
make AOC-deploy

# Validate AOC fabric
make AOC-validate
```

## Build and Deploy TelecomB Fabric Configs

```bash
# Build TelecomB Fabric Configs
make TelecomB-build

# Deploy TelecomB Fabric Configs via CVP
make TelecomB-CVP-deploy

# Deploy TelecomB Fabric Configs via eAPI (direct to switches)
make TelecomB-deploy

# Validate TelecomB fabric
make TelecomB-validate
```
