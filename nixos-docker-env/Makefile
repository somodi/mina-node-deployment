APP_NAME := nixos_local

.DEFAULT_GOAL := help


HELP_FUN = \
	%help; while(<>){push@{$$help{$$2//'targets'}},[$$1,$$3] \
	if/^([\w-_]+)\s*:.*\#\#(?:@(\w+))?\s(.*)$$/}; \
	print"$$_:\n", map"  $$_->[0]".(" "x(24-length($$_->[0])))."$$_->[1]\n",\
	@{$$help{$$_}},"\n" for keys %help; \

help: ##@misc Show this help
	@echo "Usage: make [target] ...\n"
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)


build_image: ##@docker Build docker image
	@echo "Building docker image"
	DOCKER_BUILDKIT=1 docker build -f Dockerfile -t $(APP_NAME):latest .

run_docker_image: ##@docker Run docker image directly
	@echo "Running docker image with"
	docker run -it $(APP_NAME)

run_in_docker_compose: ##@docker Run dev env in docker compose (not working)
	@echo "Launching local dev environment with docker-compose"
	DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker-compose -f docker-compose.yaml up


.PHONY: help build_image run_in_docker_compose
