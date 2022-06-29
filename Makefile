.DEFAULT_GOAL := help

HELP_FUN = \
	%help; while(<>){push@{$$help{$$2//'targets'}},[$$1,$$3] \
	if/^([\w-_]+)\s*:.*\#\#(?:@(\w+))?\s(.*)$$/}; \
	print"$$_:\n", map"  $$_->[0]".(" "x(24-length($$_->[0])))."$$_->[1]\n",\
	@{$$help{$$_}},"\n" for keys %help; \

help: ##@misc Show this help
	@echo "Usage: make [target] ...\n"
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)


up: infra config ##@global Start infra and configure it

init: ##@infra Initialize terraform
	@cd terraform && terraform init

infra: ##@infra Raise EC2 instance
	@cd terraform && terraform apply --auto-approve

config: load_ip ##@config Configure server with ansible
	@ansible-playbook ansible/mina.yaml -i ansible/inventory.ini

down: ##@global Shut down the infrastructure
	@cd terraform && terraform destroy --auto-approve

load_ip: ##@config Populate ansible inventory with EC2 ip
	echo "$(shell cd terraform && terraform output -raw ip) ansible_user=ubuntu ansible_ssh_private_key_file=ansible/secrets/aws.pem" > ansible/inventory.ini

.PHONY: help up init infra config down load_ip