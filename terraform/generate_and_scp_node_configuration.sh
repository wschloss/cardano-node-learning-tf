#!/bin/bash

set -euxo pipefail

NODE_CONFIG_FILE="../../config/node-config.yaml"
NODE_SECRET_FILE="../../config/node-secret.yaml"
SSH_PRIVATE_KEY_PATH=$1
SSH_USER=$2
NODE_PUBLIC_IP=$3
STAKE_POOL_SIG_KEY=$4
STAKE_POOL_VRF_KEY=$5
STAKE_POOL_NODE_ID=$6

cat $NODE_CONFIG_FILE | \
  sed "s/__PUBLIC_IP__/$NODE_PUBLIC_IP/g" > \
  generated_node_config.yaml

cat $NODE_SECRET_FILE | \
  sed "s/__SIG_KEY__/$(cat $STAKE_POOL_SIG_KEY)/g" | \
  sed "s/__VRF_KEY__/$(cat $STAKE_POOL_VRF_KEY)/g" | \
  sed "s/__NODE_ID__/$(cat $STAKE_POOL_NODE_ID)/g" > \
  generated_node_secret.yaml

scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i $SSH_PRIVATE_KEY_PATH generated_node_config.yaml $SSH_USER@$NODE_PUBLIC_IP:/configuration/node-config.yaml
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i $SSH_PRIVATE_KEY_PATH generated_node_secret.yaml $SSH_USER@$NODE_PUBLIC_IP:/configuration/node-secret.yaml

rm ./generated_node_config.yaml ./generated_node_secret.yaml