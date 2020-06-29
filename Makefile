REGISTRY_PROJECT_URL ?= quay.io/kmmndr/letsencrypt-alpine
# commit_sha
BUILD_ID ?= $(shell git rev-parse --short HEAD)
# branch_name
REF_ID ?= $(shell git symbolic-ref --short HEAD)

all: help
include *.mk

ci-build: docker-pull docker-build
ci-push: docker-push
ci-push-release: docker-push-release

start: docker-compose-pull docker-compose-start ##- Start
deploy: docker-compose-pull docker-compose-deploy ##- Deploy (start remotely)
stop: docker-compose-stop ##- Stop
