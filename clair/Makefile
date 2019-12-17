# Docker image namespace: wshihadeh by default
NAMESPACE ?= wshihadeh
# Image name
NAME := clair
# Docker registry
REGISTRY ?= index.docker.io
# Docker image reference
IMG := ${REGISTRY}/${NAMESPACE}/${NAME}
# tag of clair
CLAIR_VERSION ?= v0.1
# Fetch the latest commit hash
COMMIT_HASH := $$(git rev-parse HEAD)


build:
	@echo "Building Clair docker image";
	@docker build -t ${IMG}:${COMMIT_HASH} .
	@docker tag ${IMG}:${COMMIT_HASH} ${IMG}:${CLAIR_VERSION}

push:
	@echo "Push docker image";
	@docker push ${IMG}:${CLAIR_VERSION}
	@docker push ${IMG}:${COMMIT_HASH}

release: build push

shell:
	@ echo "Going inside the Clair container";
	@docker run --rm -it ${IMG}:${CLAIR_VERSION} sh

clean:
	@docker rmi -f ${IMG}:${CLAIR_VERSION}


.PHONY: server test build push clean
