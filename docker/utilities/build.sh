#!/bin/bash

set -euxo pipefail

type jq >/dev/null 2>&1 || { echo >&2 'Please install jq to use this script'; exit 1; }

CONFIG_JSON_FILE_LOCATION='../../config/config.json'

JORMUNGANDR_VERSION=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.jormungandr.version')
JORMUNGANDR_ARCH=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.jormungandr.arch')
JORMUNGANDR_OS=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.jormungandr.os')

DOCKER_REGISTRY=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.docker.registry')
DOCKER_IMAGE=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.docker.cardanoUtilities.image')

docker build \
  -t $DOCKER_REGISTRY/$DOCKER_IMAGE:latest \
  --build-arg JORMUNGANDR_VERSION=$JORMUNGANDR_VERSION \
  --build-arg JORMUNGANDR_ARCH=$JORMUNGANDR_ARCH \
  --build-arg JORMUNGANDR_OS=$JORMUNGANDR_OS \
  .