DOCKER_CLI_EXPERIMENTAL := enabled
DOCKER_BUILDKIT := 1

DOCKER_USERNAME := peaceiris
DOCKER_IMAGE_NAME := mdbook
DOCKER_HUB_BASE_NAME := ${DOCKER_USERNAME}/${DOCKER_IMAGE_NAME}
DOCKER_BASE_NAME := ghcr.io/${DOCKER_HUB_BASE_NAME}
DOCKER_VERSION := $(shell cat ./deps/Cargo.toml | grep 'mdbook = ' | awk '{print $$3}' | tr -d '"')
MDBOOK_MERMAID_VERSION := $(shell cat ./deps/Cargo.toml | grep 'mdbook-mermaid = ' | awk '{print $$3}' | tr -d '"')
MDBOOK_TOC_VERSION := $(shell cat ./deps/Cargo.toml | grep 'mdbook-toc = ' | awk '{print $$3}' | tr -d '"')
DOCKER_TAG := v${DOCKER_VERSION}
GITHUB_REF_NAME ?= local
DOCKER_SCOPE := mdbook-${GITHUB_REF_NAME}
DOCKER_OUTPUT_TYPE ?= docker
ifeq (${DOCKER_MULTI_PLATFORM}, true)
	DOCKER_PLATFORM := --platform linux/amd64,linux/arm64
	DOCKER_OUTPUT_TYPE := registry
endif
PKG_NAME := ${DOCKER_BASE_NAME}:${DOCKER_TAG}
HUB_NAME := ${DOCKER_HUB_BASE_NAME}:${DOCKER_TAG}
PKG_NAME_LATEST := ${DOCKER_BASE_NAME}:latest
HUB_NAME_LATEST := ${DOCKER_HUB_BASE_NAME}:latest

.PHONY: login-dockerhub
login-dockerhub:
	echo "${DOCKER_HUB_TOKEN}" | docker login -u "${DOCKER_USERNAME}" --password-stdin

.PHONY: login-ghcr
login-ghcr:
	echo "${GITHUB_TOKEN}" | docker login ghcr.io -u "${DOCKER_USERNAME}" --password-stdin

.PHONY: login
login: login-dockerhub login-ghcr

.PHONY: setup-buildx
setup-buildx:
	docker buildx create --use --driver docker-container
	docker buildx inspect --bootstrap
	docker version

.PHONY: build
build: build-alpine build-rust

.PHONY: build-alpine
build-alpine:
	docker buildx build . \
		--tag "${PKG_NAME}" \
		--tag "${HUB_NAME}" \
		--tag "${PKG_NAME_LATEST}" \
		--tag "${HUB_NAME_LATEST}" \
		${DOCKER_PLATFORM} \
		--annotation "index,manifest,index-descriptor,manifest-descriptor:org.opencontainers.image.authors=peaceiris (Shohei Ueda)" \
		--annotation "index,manifest,index-descriptor,manifest-descriptor:org.opencontainers.image.url=https://github.com/peaceiris/docker-mdbook" \
		--annotation "index,manifest,index-descriptor,manifest-descriptor:org.opencontainers.image.documentation=https://github.com/peaceiris/docker-mdbook/blob/main/README.md" \
		--annotation "index,manifest,index-descriptor,manifest-descriptor:org.opencontainers.image.source=https://github.com/peaceiris/docker-mdbook/blob/main/Dockerfile" \
		--annotation "index,manifest,index-descriptor,manifest-descriptor:org.opencontainers.image.description=Alpine-based Docker Images for mdBook" \
		--annotation "index,manifest,index-descriptor,manifest-descriptor:org.opencontainers.image.licenses=MIT" \
		--annotation "index,manifest,index-descriptor,manifest-descriptor:org.opencontainers.image.version=${DOCKER_TAG}" \
		--output "type=${DOCKER_OUTPUT_TYPE}" \
		--cache-from "type=gha,scope=${DOCKER_SCOPE}" \
		--cache-to "type=gha,mode=max,scope=${DOCKER_SCOPE}" \
		--build-arg MDBOOK_VERSION="${DOCKER_VERSION}" \
		--build-arg BASE_IMAGE="alpine:3.20" \
		--build-arg MDBOOK_MERMAID_VERSION="${MDBOOK_MERMAID_VERSION}" \
		--build-arg MDBOOK_TOC_VERSION="${MDBOOK_TOC_VERSION}"

.PHONY: build-rust
build-rust:
	docker buildx build . \
		--tag "${PKG_NAME}-rust" \
		--tag "${HUB_NAME}-rust" \
		--tag "${PKG_NAME_LATEST}-rust" \
		--tag "${HUB_NAME_LATEST}-rust" \
		${DOCKER_PLATFORM} \
		--annotation "index,manifest,index-descriptor,manifest-descriptor:org.opencontainers.image.authors=peaceiris (Shohei Ueda)" \
		--annotation "index,manifest,index-descriptor,manifest-descriptor:org.opencontainers.image.url=https://github.com/peaceiris/docker-mdbook" \
		--annotation "index,manifest,index-descriptor,manifest-descriptor:org.opencontainers.image.documentation=https://github.com/peaceiris/docker-mdbook/blob/main/README.md" \
		--annotation "index,manifest,index-descriptor,manifest-descriptor:org.opencontainers.image.source=https://github.com/peaceiris/docker-mdbook/blob/main/Dockerfile" \
		--annotation "index,manifest,index-descriptor,manifest-descriptor:org.opencontainers.image.description=Alpine-based Docker Images for mdBook" \
		--annotation "index,manifest,index-descriptor,manifest-descriptor:org.opencontainers.image.licenses=MIT" \
		--annotation "index,manifest,index-descriptor,manifest-descriptor:org.opencontainers.image.version=${DOCKER_TAG}-rust" \
		--output "type=${DOCKER_OUTPUT_TYPE}" \
		--cache-from "type=gha,scope=${DOCKER_SCOPE}" \
		--cache-to "type=gha,mode=max,scope=${DOCKER_SCOPE}" \
		--build-arg MDBOOK_VERSION="${DOCKER_VERSION}" \
		--build-arg BASE_IMAGE="rust:1.78-alpine3.20" \
		--build-arg MDBOOK_MERMAID_VERSION="${MDBOOK_MERMAID_VERSION}" \
		--build-arg MDBOOK_TOC_VERSION="${MDBOOK_TOC_VERSION}"

.PHONY: test
test:
	@docker run --rm "${HUB_NAME}" --version
	@docker run --rm "${HUB_NAME}-rust" --version
