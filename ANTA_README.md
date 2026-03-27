# ANTA - Arista Network Testing Automation

## Install ANTA

```bash
pip install 'anta[cli]'
```

## Create ANTA inventory from Ansible Inventory

```bash
anta get from-ansible \
     --ansible-inventory sites/AOC/inventory.yml \
     --ansible-group AOC_FABRIC \
     --output sites/AOC/anta_inventory.yml
```

## Sample Test catalog - tests/all.yml

```bash
# tests/all.yml

anta.tests.system:
  - VerifyUptime:
      minimum: 86400
  - VerifyReloadCause:
  - VerifyNTP:

anta.tests.routing:
  generic:
    - VerifyRoutingTableEntry:
        vrf: default
        routes:
          - 0.0.0.0

anta.tests.services:
  - VerifyDNSLookup:
      domain_names:
        - www.cv-prod-us-central1-c.arista.io
```

## Run NRFU (Network Ready for Use) test

```bash
anta nrfu \
   -u arista -p <insert lab password> \
   -i sites/AOC/anta_inventory.yml \
   -c tests/all.yml \
   table

# target single device
anta nrfu -u arista -p <insert lab password> -i sites/AOC/anta_inventory.yml -c tests/all.yml  --device AOC-DB-1

# single test
anta nrfu -u arista -p <insert lab password> -i sites/AOC/anta_inventory.yml -c tests/all.yml  --test VerifyNTP
```

## Other commands

```bash
# Validate a check
anta check catalog -c tests/static_test_catalog.yml 

# Single Device
anta nrfu --device DC1-LEAF1A [text|json|table|tpl-report]

# Group by results
anta nrfu table --group-by [device|test]

# Run a single test
anta nrfu --test VerifyCPUUtilization table


# Run a single test, show everything skipped or failed
anta nrfu --test VerifyCPUUtilization --hide success table

# snapshots - Execute list of commands per device and store the output 
anta exec snapshot --commands-list tests/snapshot.yml -u arista -p <insert lab password> -i sites/AOC/anta_inventory.yml -o SNAPSHOTS

# debug - run commands on a device
anta debug run-cmd -u arista -p <insert lab password> -i sites/AOC/anta_inventory.yml --device AOC-DB-1 --command "show version"
anta debug run-cmd -u arista -p <insert lab password> -i sites/AOC/anta_inventory.yml --device AOC-DB-1 --command "show interfaces status" --ofmt text
```