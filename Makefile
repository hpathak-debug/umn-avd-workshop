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

.PHONY: TelecomB-build
TelecomB-build: ## Build Configs
	ansible-playbook playbooks/build.yml -i sites/TelecomB/inventory.yml -e "target_hosts=TelecomB_FABRIC"

.PHONY: TelecomB-deploy
TelecomB-deploy: ## Deploy Configs via eAPI
	ansible-playbook playbooks/deploy.yml -i sites/TelecomB/inventory.yml -e "target_hosts=TelecomB_FABRIC"

.PHONY: TelecomB-CVP-deploy
TelecomB-CVP-deploy: ## Deploy Configs via CloudVision Static Configuration Studio
	ansible-playbook playbooks/cv_deploy.yml -i sites/TelecomB/inventory.yml -e "target_hosts=TelecomB_FABRIC"

.PHONY: TelecomB-validate
TelecomB-validate: ## Validate network state
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
all: AOC-build TelecomB-build AOC-CVP-deploy TelecomB-CVP-deploy

########################################################
# Reset device back to undefined container
########################################################

.PHONY: reset_to_undefined
reset_to_undefined: ## Reset devices to undefined container in CVP
	ansible-playbook playbooks/reset_to_undefined.yml -i sites/AOC/inventory.yml
