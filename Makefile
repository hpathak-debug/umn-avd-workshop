.PHONY: help
help: ## Display help message
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


########################################################
# AOC
########################################################

.PHONY: AOC-build
AOC-build: ## Build Configs
	ansible-playbook playbooks/build.yml -i sites/AOC/inventory.yml -e "target_hosts=AOC_FABRIC"

.PHONY: AOC-deploy
AOC-deploy: ## Deploy Configs via eAPI
	ansible-playbook playbooks/deploy.yml -i sites/AOC/inventory.yml -e "target_hosts=AOC_FABRIC"


.PHONY: AOC-CVP-deploy
AOC-CVP-deploy: ## Deploy Configs via CloudVision Static Configuration Studio
	ansible-playbook playbooks/cv_deploy.yml -i sites/AOC/inventory.yml -e "target_hosts=AOC_FABRIC"

.PHONY: AOC-validate
AOC-validate: ## Validate network state
	ansible-playbook playbooks/validate.yml -i sites/AOC/inventory.yml -e "target_hosts=AOC_FABRIC"

########################################################
# TelecomB
########################################################

.PHONY: build-site-2
build-site-2: ## Build Configs
	ansible-playbook playbooks/build.yml -i sites/TelecomB/inventory.yml -e "target_hosts=TelecomB_FABRIC"

.PHONY: cvp-site-2
cvp-site-2: ## Deploy Configs via CloudVision Static Configuration Studio
	ansible-playbook playbooks/cv_deploy.yml -i sites/TelecomB/inventory.yml -e "target_hosts=TelecomB_FABRIC"

.PHONY: validate-site-2
validate-site-2: ## Validate network state
	ansible-playbook playbooks/validate.yml -i sites/TelecomB/inventory.yml -e "target_hosts=TelecomB_FABRIC"

########################################################
# WAN & Hosts - Lab Prep
########################################################

.PHONY: preplab
preplab: ## Deploy Configs via eAPI
	ansible-playbook playbooks/preplab.yml -i extra_configs/inventory.yml -e "target_hosts=LAB"

########################################################
# Build and deploy all sites
########################################################

.PHONY: all
all: build-site-1 build-site-2 deploy-site-1 deploy-site-2

########################################################
# Reset device back to undefined container
########################################################

.PHONY: reset_to_undefined
reset_to_undefined: ## Reset devices to undefined container in CVP
	ansible-playbook playbooks/reset_to_undefined.yml -i sites/AOC/inventory.yml
	ansible-playbook playbooks/reset_to_undefined.yml -i sites/TelecomB/inventory.yml