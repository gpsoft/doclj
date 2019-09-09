IMAGENAME ?= cljenvi
CONTAINERNAME ?= cljenv
DK_USER ?= dk_user

CMD_LIST := image dev attach

all:
	@echo Usage:
	@echo make image
	@echo make dev
	@echo make attach

.PHONY: $(CMD_LIST)
.SILENT: $(CMD_LIST)

# Build a docker image.
image:
	cd docker; docker build --tag=$(IMAGENAME) .

# Start development
dev:
	docker run --rm -it \
		--volume $(shell pwd):/home/$(DK_USER)/proj \
		--volume ~/.m2:/home/$(DK_USER)/.m2 \
		--publish 8080:8080 \
		--publish 3000:3000 \
		--publish 3449:3449 \
		--publish 9500:9500 \
		--publish 3575:3575 \
		--hostname $(CONTAINERNAME) \
		--name $(CONTAINERNAME) \
		--workdir /home/$(DK_USER)/proj \
		$(IMAGENAME) bash dev.sh --login

# Attach to the running container.
attach:
	docker exec -it \
		--user $(DK_USER) \
		$(CONTAINERNAME) bash

%:
	@:

