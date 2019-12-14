# Docker image namespace: wshihadeh by default
NAMESPACE ?= wshihadeh
# Image name
NAME := nginx
# Docker registry
REGISTRY ?= index.docker.io
# Docker image reference
IMG := ${REGISTRY}/${NAMESPACE}/${NAME}
# tag of nginx
NGINX_VERSION ?= v0.1
# Fetch the latest commit hash
COMMIT_HASH := $$(git rev-parse HEAD)


build:
	@echo "Building nginx docker image";
	@docker build -t ${IMG}:${COMMIT_HASH} .
	@docker tag ${IMG}:${COMMIT_HASH} ${IMG}:${NGINX_VERSION}

push:
	@echo "Push docker image";
	@docker push ${IMG}:${NGINX_VERSION}
	@docker push ${IMG}:${COMMIT_HASH}

server:
	@echo "Starting Nginx container";
	@docker run --rm -it -p 8080:80 ${IMG}:${NGINX_VERSION} /bin/bash -c "nginx -g 'daemon off;'"

shell: build
	@ echo "Going inside the nginx container";
	@docker run --rm -it ${IMG}:${NGINX_VERSION} bash

clean:
	@docker rmi -f ${IMG}:${NGINX_VERSION}

# Test the syntax of the configuration files
test: build
	@ echo "Validating nginx configuration";
	@docker run --rm -it ${IMG}:${NGINX_VERSION} nginx -c /etc/nginx/nginx.conf -t

output:
	@ echo "Checking nginx configuration";
	@docker run --rm -it ${IMG}:${NGINX_VERSION} nginx -c /etc/nginx/nginx.conf -T

.PHONY: server test build push clean
