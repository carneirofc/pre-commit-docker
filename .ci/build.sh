#!/bin/sh
IMAGE=carneirfc/pre-commit
PRE_COMMIT_HOOKS_VERSION=4.2.0
AUTHOR=Claudio F. Carneiro <claudiofcarneiro@hotmail.com>
BRANCH=$(git branch --no-color --show-current)
BUILD_DATE=$(date -I)
BUILD_DATE_RFC339=$(date --rfc-3339=seconds)
COMMIT_HASH=$(git rev-parse --short HEAD)
DEPARTMENT=GAS
DOCKER_IMAGE_PREFIX=${DOCKER_IMAGE_PREFIX}
REPOSITORY=$(git remote show origin |grep Fetch|awk '{ print $3 }')

docker build --build-arg PRE_COMMIT_HOOKS_VERSION=${PRE_COMMIT_HOOKS_VERSION} ${IMAGE} .

docker tag ${IMAGE} ${IMAGE}:latest
docker tag ${IMAGE} ${IMAGE}:${COMMIT_HASH}-${BUILD_DATE}
