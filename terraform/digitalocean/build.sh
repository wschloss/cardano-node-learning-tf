#!/bin/bash

set -euxo pipefail

type jq >/dev/null 2>&1 || { echo >&2 'Please install jq to use this script'; exit 1; }
type terraform >/dev/null 2>&1 || { echo >&2 'Please install terraform to use this script'; exit 1; }

CONFIG_FILE_DIRECTORY='../../config'
CONFIG_JSON_FILE_NAME='config.json'
CONFIG_JSON_FILE_LOCATION=$CONFIG_FILE_DIRECTORY/$CONFIG_JSON_FILE_NAME

JORMUNGANDR_VERSION=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.jormungandr.version')
JORMUNGANDR_GENESIS_BLOCK_HASH=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.jormungandr.genesisBlockHash')
JORMUNGANDR_NODE_PRIVATE_ID=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.jormungandr.nodePrivateId')
JORMUNGANDR_STAKE_POOL_SIG_KEY=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.jormungandr.stakePool.sigKey')
JORMUNGANDR_STAKE_POOL_VRF_KEY=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.jormungandr.stakePool.vrfKey')
JORMUNGANDR_STAKE_POOL_NODE_ID=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.jormungandr.stakePool.nodeId')
DOCKER_REGISTRY=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.docker.registry')
DOCKER_IMAGE=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.docker.cardanoNode.image')

DO_ACCESS_TOKEN_FILE=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.terraform.digitalOcean.doAccessTokenFile')
NODE_DROPLET_SIZE=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.terraform.digitalOcean.nodeDropletSize')
IMAGE=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.terraform.digitalOcean.image')
REGION=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.terraform.digitalOcean.region')
TRUSTED_INGRESS_CIDRS=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.terraform.digitalOcean.trustedIngressCidrs')
SSH_PUBLIC_KEY_PATH=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.terraform.digitalOcean.sshPublicKeyPath')
SSH_PRIVATE_KEY_PATH=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.terraform.digitalOcean.sshPrivateKeyPath')
SSH_USER=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.terraform.digitalOcean.sshUser')
NODE_REST_PORT=$(cat $CONFIG_FILE_DIRECTORY/node-config.yaml | sed 's/\"//g' | sed -n '/^rest/{n;p;}' | cut -d ':' -f3)
NODE_GRPC_PORT=$(cat $CONFIG_FILE_DIRECTORY/node-config.yaml | sed 's/\"//g' | sed -n '/^p2p/{n;p;}' | cut -d '/' -f5)
NODE_DOCKER_IMAGE=$DOCKER_REGISTRY/$DOCKER_IMAGE:$JORMUNGANDR_VERSION

terraform \
  apply \
  -var "do_access_token_file=$DO_ACCESS_TOKEN_FILE" \
  -var "node_droplet_size=$NODE_DROPLET_SIZE" \
  -var "image=$IMAGE" \
  -var "region=$REGION" \
  -var "trusted_ingress_cidrs=$TRUSTED_INGRESS_CIDRS" \
  -var "ssh_public_key_path=$SSH_PUBLIC_KEY_PATH" \
  -var "ssh_private_key_path=$SSH_PRIVATE_KEY_PATH" \
  -var "ssh_user=$SSH_USER" \
  -var "node_rest_port=$NODE_REST_PORT" \
  -var "node_grpc_port=$NODE_GRPC_PORT" \
  -var "node_docker_image=$NODE_DOCKER_IMAGE" \
  -var "genesis_block_hash=$JORMUNGANDR_GENESIS_BLOCK_HASH" \
  -var "node_private_id=$JORMUNGANDR_NODE_PRIVATE_ID" \
  -var "stake_pool_sig_key=$JORMUNGANDR_STAKE_POOL_SIG_KEY" \
  -var "stake_pool_vrf_key=$JORMUNGANDR_STAKE_POOL_VRF_KEY" \
  -var "stake_pool_node_id=$JORMUNGANDR_STAKE_POOL_NODE_ID"