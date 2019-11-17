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

AWS_PROFILE=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.terraform.aws.awsProfile')
REGION=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.terraform.aws.region')
NODE_INSTANCE_TYPE=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.terraform.aws.nodeInstanceType')
AMI=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.terraform.aws.ami')
INSTANCE_COUNT=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.terraform.aws.instanceCount')
TRUSTED_INGRESS_CIDRS=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.terraform.aws.trustedIngressCidrs')
SSH_PUBLIC_KEY_PATH=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.terraform.aws.sshPublicKeyPath')
SSH_PRIVATE_KEY_PATH=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.terraform.aws.sshPrivateKeyPath')
SSH_USER=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.terraform.aws.sshUser')
NODE_STORAGE_SIZE_GB=$(cat $CONFIG_JSON_FILE_LOCATION | jq -r '.terraform.aws.nodeStorageSizeGb')
NODE_REST_PORT=$(cat $CONFIG_FILE_DIRECTORY/node-config.yaml | sed 's/\"//g' | sed -n '/^rest/{n;p;}' | cut -d ':' -f3)
NODE_GRPC_PORT=$(cat $CONFIG_FILE_DIRECTORY/node-config.yaml | sed 's/\"//g' | sed -n '/^p2p/{n;p;}' | cut -d '/' -f5)
NODE_DOCKER_IMAGE=$DOCKER_REGISTRY/$DOCKER_IMAGE:$JORMUNGANDR_VERSION

terraform \
  apply \
  -var "aws_profile=$AWS_PROFILE" \
  -var "region=$REGION" \
  -var "node_instance_type=$NODE_INSTANCE_TYPE" \
  -var "ami=$AMI" \
  -var "instance_count=$INSTANCE_COUNT" \
  -var "trusted_ingress_cidrs=$TRUSTED_INGRESS_CIDRS" \
  -var "ssh_public_key_path=$SSH_PUBLIC_KEY_PATH" \
  -var "ssh_private_key_path=$SSH_PRIVATE_KEY_PATH" \
  -var "ssh_user=$SSH_USER" \
  -var "node_storage_size_gb=$NODE_STORAGE_SIZE_GB" \
  -var "node_rest_port=$NODE_REST_PORT" \
  -var "node_grpc_port=$NODE_GRPC_PORT" \
  -var "node_docker_image=$NODE_DOCKER_IMAGE" \
  -var "genesis_block_hash=$JORMUNGANDR_GENESIS_BLOCK_HASH" \
  -var "node_private_id=$JORMUNGANDR_NODE_PRIVATE_ID" \
  -var "stake_pool_sig_key=$JORMUNGANDR_STAKE_POOL_SIG_KEY" \
  -var "stake_pool_vrf_key=$JORMUNGANDR_STAKE_POOL_VRF_KEY" \
  -var "stake_pool_node_id=$JORMUNGANDR_STAKE_POOL_NODE_ID"